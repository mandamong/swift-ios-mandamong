//
//  VerifyEmailDTO.swift
//  LoginData
//
//  Created by Swain Yun on 9/20/25.
//

import Foundation

enum VerifyEmailDTO {
    struct Request: Encodable {
        let email: String
        let code: String
    }
}
