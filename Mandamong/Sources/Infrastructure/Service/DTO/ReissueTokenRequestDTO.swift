//
//  ReissueTokenRequestDTO.swift
//  Mandamong
//
//  Created by Swain Yun on 9/7/25.
//

import Foundation

enum ReissueTokenDTO {
    struct Request: Encodable {
        let refreshToken: String
    }
    
    struct Response: Decodable {
        let id: Int
        let accessToken, refreshToken: String
    }
}
