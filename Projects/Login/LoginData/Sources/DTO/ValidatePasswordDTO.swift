//
//  ValidatePasswordDTO.swift
//  LoginData
//
//  Created by Swain Yun on 9/19/25.
//

import Foundation

enum ValidatePasswordDTO {
    struct Request: Encodable {
        let password: String
    }
}
