//
//  Endpoint.swift
//  LoginEndpoint
//
//  Created by Swain Yun on 9/18/25.
//

import Foundation

enum LoginEndpoint {
    // MARK: - No tokens required
    case checkNicknameDuplication(nickname: String)
    case checkEmailDuplication(email: String)
    case requestEmailAuthenticationCode(EmailAuthenticationCodeDTO.Request)
    case verifyEmail(email: String, code: String)
    case register(email: String, password: String, nickname: String, image: Data, languageID: String)
    case login(LoginDTO.Request)
    case reissueToken(ReissueTokenDTO.Request)
    
    // MARK: - Tokens required
    case updateProfile(nickname: String?, image: Data?, password: String?)
    case validatePassword(ValidatePasswordDTO.Request)
    case resetPassword(ResetPasswordDTO.Request)
    case unregister
    case logout
}
