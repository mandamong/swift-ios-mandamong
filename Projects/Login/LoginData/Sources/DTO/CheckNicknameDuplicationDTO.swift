//
//  CheckNicknameDuplicationDTO.swift
//  LoginData
//
//  Created by Swain Yun on 9/20/25.
//

import Foundation

enum CheckNicknameDuplicationDTO {
    struct Request: Encodable {
        let nickname: String
    }
}
