//
//  CheckEmailDuplicationDTO.swift
//  LoginData
//
//  Created by Swain Yun on 9/20/25.
//

import Foundation

enum CheckEmailDuplicationDTO {
    struct Request: Encodable {
        let email: String
    }
}
