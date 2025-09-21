//
//  APIEndpoint.swift
//  Network
//
//  Created by 김진웅 on 9/22/25.
//

import Foundation
import Alamofire

// MARK: - APIEndpoint
protocol APIEndpoint: URLRequestConvertible {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var task: APITask { get }
}

// MARK: - URLRequestConvertible Implementation
extension APIEndpoint {
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: baseURL)?.appendingPathComponent(path) else { 
            throw AFError.invalidURL(url: baseURL + path) 
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        
        if let headers {
            headers.forEach { header in
                urlRequest.setValue(header.value, forHTTPHeaderField: header.name)
            }
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        switch task {
        case .requestPlain, .uploadMultipart:
            break
        case .requestParameters(let parameters, let encoding):
            urlRequest = try encoding.encode(urlRequest, with: parameters)
        case .requestJSONEncodable(let object):
            do {
                urlRequest.httpBody = try JSONEncoder().encode(object)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}

// MARK: - APITask
enum APITask {
    case requestPlain
    case requestParameters(parameters: Parameters, encoding: ParameterEncoding)
    case requestJSONEncodable(Encodable)
    case uploadMultipart(MultipartFormData)
}
