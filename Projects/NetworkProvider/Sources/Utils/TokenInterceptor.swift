//
//  TokenInterceptor.swift
//  Network
//
//  Created by 김진웅 on 9/22/25.
//

import Foundation
import Alamofire

public final class TokenInterceptor: RequestInterceptor {
    // TODO: 토큰 관리 객체 주입
    
    public init() {}

    public func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        // TODO: 토큰 삽입
        
        completion(.success(urlRequest))
    }
    
    public func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        // TODO: 토큰 재발급 로직 구현
        
        completion(.doNotRetry)
    }
}
