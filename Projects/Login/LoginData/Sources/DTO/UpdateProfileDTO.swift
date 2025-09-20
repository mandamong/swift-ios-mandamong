//
//  UpdateProfileDTO.swift
//  LoginData
//
//  Created by Swain Yun on 9/20/25.
//

import Foundation

enum UpdateProfileDTO {
    struct Request: Encodable {
        let nickname: String?
        let image: Data?
        let password: String?
    }
}
