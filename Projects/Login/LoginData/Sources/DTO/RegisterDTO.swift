//
//  RegisterDTO.swift
//  LoginData
//
//  Created by Swain Yun on 9/20/25.
//

import Foundation

enum RegisterDTO {
    struct Request: Encodable {
        let email: String
        // TODO: 비밀번호 평문 전달? -> 백엔드와 상의 필요
//        let password: String
        let nickname: String
        let image: Data
        // TODO: 다국어 지원용? 제공 국가 종류 확인해서 열거형으로 관리할 수 있을지 확인
        let languageID: String
    }
}
