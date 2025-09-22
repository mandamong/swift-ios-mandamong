//
//  NetworkService.swift
//  Network
//
//  Created by 김진웅 on 9/22/25.
//

import Foundation
import Alamofire

// MARK: - NetworkServiceProtocol
public protocol NetworkServiceProtocol {
    associatedtype Endpoint: APIEndpoint
    
    func request(_ endpoint: Endpoint) async throws(NetworkError)
    func request<T: Decodable>(_ endpoint: Endpoint) async throws(NetworkError) -> ResponseDTO<T>
}

// MARK: - NetworkService
public final class NetworkService<Endpoint: APIEndpoint>: NetworkServiceProtocol {
    private let session: Session
    private let decoder: JSONDecoder
    
    public init(
        interceptor: (any RequestInterceptor)? = nil,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = Session(
            interceptor: interceptor,
            eventMonitors: [NetworkLogger()]
        )
        self.decoder = decoder
    }
    
    public func request(_ endpoint: Endpoint) async throws(NetworkError) {
        do {
            _ = try await session.request(endpoint)
                .validate()
                .serializingData()
                .value
        } catch let error as AFError {
            throw mapError(error)
        } catch {
            throw NetworkError.unknown(underlyingError: error)
        }
    }
    
    public func request<T: Decodable>(_ endpoint: Endpoint) async throws(NetworkError) -> ResponseDTO<T> {
        do {
            switch endpoint.task {
            case .uploadMultipart(let multipartFormData):
                return try await session.upload(multipartFormData: multipartFormData, with: endpoint)
                    .validate()
                    .serializingDecodable(ResponseDTO<T>.self, decoder: decoder)
                    .value
            default:
                return try await session.request(endpoint)
                    .validate()
                    .serializingDecodable(ResponseDTO<T>.self, decoder: decoder)
                    .value
            }
        } catch let error as AFError {
            throw mapError(error)
        } catch {
            throw NetworkError.decodingFailed(underlyingError: error)
        }
    }
}

// MARK: - Private Methods
private extension NetworkService {
    func mapError(_ error: AFError) -> NetworkError {
        if error.isInvalidURLError {
            return .invalidRequest(.invalidURL(error.url?.absoluteString ?? "Unknown URL"))
        }
        
        switch error {
        case .parameterEncodingFailed(let reason):
            switch reason {
            case .jsonEncodingFailed(let error):
                return .invalidRequest(.jsonBodyEncodingFailed(underlyingError: error))
            default:
                return .invalidRequest(.parameterEncodingFailed(underlyingError: error))
            }
            
        case .multipartEncodingFailed:
            return .invalidRequest(.multipartEncodingFailed(underlyingError: error))
            
        case .responseValidationFailed(let reason):
            switch reason {
            case .unacceptableStatusCode(let code):
                let statusCodeError = StatusCodeError(statusCode: code)
                return .invalidResponse(.unacceptableStatusCode(statusCodeError))
            default:
                return .invalidResponse(.noResponse)
            }
            
        case .responseSerializationFailed:
            return .decodingFailed(underlyingError: error)
            
        case .sessionTaskFailed(error: let underlyingError):
            if let urlError = underlyingError as? URLError {
                switch urlError.code {
                case .timedOut:
                    return .invalidResponse(.timeout(underlyingError: urlError))
                case .notConnectedToInternet:
                    return .invalidRequest(.networkUnavailable)
                default:
                    return .unknown(underlyingError: urlError)
                }
            }
            return .unknown(underlyingError: underlyingError)
            
        default:
            return .unknown(underlyingError: error)
        }
    }
}
