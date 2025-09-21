//
//  Tokens.swift
//  Network
//
//  Created by Swain Yun on 9/20/25.
//

import Foundation

struct Tokens: Codable {
    private struct Constant {
        static let accessTokenValidityDuration: TimeInterval = 60 * 10              // 유효기간: 10분
        static let refreshTokenValidityDuration: TimeInterval = 60 * 60 * 24 * 30   // 유효기간: 30일
        static let threshold: TimeInterval = 60 * 3                                 // Clock skew: 3분
    }
    
    let accessToken: String
    let refreshToken: String
    let createdAt: Date
    
    init(
        accessToken: String,
        refreshToken: String,
        createdAt: Date = .now
    ) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.createdAt = createdAt
    }
    
    private func isExpired(validityDuration: TimeInterval, at date: Date) -> Bool {
        let expirationDate = createdAt.addingTimeInterval(validityDuration)
        let safeExpirationDate = expirationDate.addingTimeInterval(-Constant.threshold)
        return date > safeExpirationDate
    }
    
    /// 액세스 토큰의 만료 여부를 확인합니다.
    /// - Parameters:
    ///     - date: 기준 시각
    ///
    /// - Note:
    ///     `date` 파라미터의 기본값은 현재 시각(`Date.now`) 입니다.
    func isAccessTokenExpired(_ date: Date = .now) -> Bool {
        isExpired(validityDuration: Constant.accessTokenValidityDuration, at: date)
    }
    
    /// 리프레시 토큰의 만료 여부를 확인합니다.
    /// - Parameters:
    ///     - date: 기준 시각
    ///
    /// - Note:
    ///     `date` 파라미터의 기본값은 현재 시각(`Date.now`) 입니다.
    func isRefreshTokenExpired(_ date: Date = .now) -> Bool {
        isExpired(validityDuration: Constant.refreshTokenValidityDuration, at: date)
    }
}
