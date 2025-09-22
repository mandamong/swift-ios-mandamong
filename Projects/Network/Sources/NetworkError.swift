//
//  NetworkError.swift
//  Network
//
//  Created by 김진웅 on 9/22/25.
//

import Foundation

// MARK: - NetworkError
public enum NetworkError: Error, LocalizedError {
    case invalidRequest(RequestError)
    case invalidResponse(ResponseError)
    case decodingFailed(underlyingError: Error)
    case unknown(underlyingError: Error)
    
    public var errorDescription: String? {
        switch self {
        case .invalidRequest(let error):
            return "잘못된 요청: \(error.localizedDescription)"
        case .invalidResponse(let error):
            return "잘못된 응답: \(error.localizedDescription)"
        case .decodingFailed(let error):
            return "디코딩 실패: \(error.localizedDescription)"
        case .unknown(let error):
            return "알 수 없는 에러: \(error.localizedDescription)"
        }
    }
}

// MARK: - RequestError
public enum RequestError: Error, LocalizedError {
    case invalidURL(String)
    case networkUnavailable
    case parameterEncodingFailed(underlyingError: Error)
    case multipartEncodingFailed(underlyingError: Error)
    case jsonBodyEncodingFailed(underlyingError: Error)
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL(let url):
            return "유효하지 않은 URL입니다: \(url)"
        case .networkUnavailable:
            return "네트워크 연결이 없습니다."
        case .parameterEncodingFailed(let error):
            return "요청 파라미터 인코딩에 실패했습니다: \(error.localizedDescription)"
        case .multipartEncodingFailed(let error):
            return "멀티파트 데이터 인코딩에 실패했습니다: \(error.localizedDescription)"
        case .jsonBodyEncodingFailed(let error):
            return "JSON 바디 인코딩에 실패했습니다: \(error.localizedDescription)"
        }
    }
}

// MARK: - ResponseError
public enum ResponseError: Error, LocalizedError {
    case unacceptableStatusCode(StatusCodeError)
    case timeout(underlyingError: Error)
    case noData
    
    public var errorDescription: String? {
        switch self {
        case .unacceptableStatusCode(let error):
            return error.localizedDescription
        case .timeout(let error):
            return "응답 시간이 초과되었습니다: \(error.localizedDescription)"
        case .noData:
            return "응답 데이터가 없습니다."
        }
    }
}

// MARK: - StatusCodeError
public enum StatusCodeError: Error, LocalizedError {
    case badRequest // 400
    case unauthorized // 401
    case forbidden // 403
    case notFound // 404
    case methodNotAllowed // 405
    case requestTimeout // 408
    case conflict // 409
    
    case internalServerError // 500
    case notImplemented // 501
    case badGateway // 502
    case serviceUnavailable // 503
    case gatewayTimeout // 504
    
    case unhandled(code: Int)
    
    public init(statusCode: Int) {
        switch statusCode {
        case 400: self = .badRequest
        case 401: self = .unauthorized
        case 403: self = .forbidden
        case 404: self = .notFound
        case 405: self = .methodNotAllowed
        case 408: self = .requestTimeout
        case 409: self = .conflict
        case 500: self = .internalServerError
        case 501: self = .notImplemented
        case 502: self = .badGateway
        case 503: self = .serviceUnavailable
        case 504: self = .gatewayTimeout
        default: self = .unhandled(code: statusCode)
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .badRequest:
            return "잘못된 요청입니다. (400)"
        case .unauthorized:
            return "인증되지 않은 요청입니다. (401)"
        case .forbidden:
            return "접근이 금지되었습니다. (403)"
        case .notFound:
            return "요청한 리소스를 찾을 수 없습니다. (404)"
        case .methodNotAllowed:
            return "허용되지 않은 메소드입니다. (405)"
        case .requestTimeout:
            return "요청 시간이 초과되었습니다. (408)"
        case .conflict:
            return "요청이 충돌했습니다. (409)"
        case .internalServerError:
            return "서버 내부 에러입니다. (500)"
        case .notImplemented:
            return "구현되지 않은 요청입니다. (501)"
        case .badGateway:
            return "게이트웨이 에러입니다. (502)"
        case .serviceUnavailable:
            return "서비스를 사용할 수 없습니다. (503)"
        case .gatewayTimeout:
            return "게이트웨이 시간 초과입니다. (504)"
        case .unhandled(let code):
            return "처리되지 않은 상태 코드입니다. (코드: \(code))"
        }
    }
}
