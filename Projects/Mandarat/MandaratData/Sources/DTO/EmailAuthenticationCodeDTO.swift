//
//  EmailAuthenticationCodeDTO.swift
//  MandaratData
//
//  Created by Swain Yun on 9/18/25.
//

import Foundation

enum EmailAuthenticationCodeDTO {
    struct Request: Encodable {
        let email: String
    }
}
