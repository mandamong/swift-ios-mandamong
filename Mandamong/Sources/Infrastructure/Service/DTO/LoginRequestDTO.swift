//
//  LoginRequestDTO.swift
//  Mandamong
//
//  Created by Swain Yun on 9/7/25.
//

import Foundation

enum LoginDTO {
    struct Request: Encodable {
        let email: String
        let password: String
    }
    
    struct Response: Decodable {
        let id: Int
        let email, nickname: String
        let image: String
        let language, accessToken, refreshToken: String
    }
}
