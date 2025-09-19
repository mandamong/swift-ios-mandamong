//
//  ResetPasswordDTO.swift
//  LoginData
//
//  Created by Swain Yun on 9/19/25.
//

import Foundation

enum ResetPasswordDTO {
    struct Request: Encodable {
        let email: String
    }
    
    struct Response: Decodable {
        let nickname: String?
        let password: String?
        let imageURL: URL?
    }
}
