//
//  EmailAuthenticationCodeRequestDTO.swift
//  Mandamong
//
//  Created by Swain Yun on 9/7/25.
//

import Foundation

enum EmailAuthenticationCodeDTO {
    struct Request: Encodable {
        let email: String
    }
}
