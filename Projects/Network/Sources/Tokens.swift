//
//  Tokens.swift
//  Network
//
//  Created by Swain Yun on 9/20/25.
//

import Foundation

struct Tokens: Codable {
    private static let accessTokenValidityDuration: TimeInterval = 60 * 10
    
    let accessToken: String     // 유효기간: 10분
    let refreshToken: String    // 유효기간: 30일
    let createdAt: Date
    var isExpired: Bool {
        let expirationDate = createdAt.addingTimeInterval(Self.accessTokenValidityDuration)
        return .now > expirationDate
    }
    
    init(
        accessToken: String,
        refreshToken: String,
        createdAt: Date = .now
    ) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.createdAt = createdAt
    }
}
