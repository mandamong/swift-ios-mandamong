//
//  Endpoint.swift
//  MandaratData
//
//  Created by Swain Yun on 9/18/25.
//

import Foundation
import Moya

enum Endpoint {
    case checkNicknameDuplication(nickname: String)
    case checkEmailDuplication(email: String)
    case requestEmailAuthenticationCode(EmailAuthenticationCodeDTO.Request)
    case verifyEmail(email: String, code: String)
    case register(email: String, password: String, nickname: String, image: Data, languageID: String)
    case login(LoginDTO.Request)
    case reissueToken(ReissueTokenDTO.Request)
}
