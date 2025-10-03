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
    case unknown(underlyingError: Error)
    
    public var errorDescription: String? {
        switch self {
        case .invalidRequest(let error):
            return "잘못된 요청: \(error.localizedDescription)"
        case .invalidResponse(let error):
            return "잘못된 응답: \(error.localizedDescription)"
        case .unknown(let error):
            return "알 수 없는 에러: \(error.localizedDescription)"
        }
    }
}
