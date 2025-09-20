//
//  Endpoint.swift
//  LoginEndpoint
//
//  Created by Swain Yun on 9/18/25.
//

import Foundation

enum LoginEndpoint {
    // MARK: - No tokens required
    case checkNicknameDuplication(CheckNicknameDuplicationDTO.Request)
    case checkEmailDuplication(CheckEmailDuplicationDTO.Request)
    case requestEmailAuthenticationCode(EmailAuthenticationCodeDTO.Request)
    case verifyEmail(VerifyEmailDTO.Request)
    case register(RegisterDTO.Request)
    case login(LoginDTO.Request)
    case reissueToken(ReissueTokenDTO.Request)
    
    // MARK: - Tokens required
    case updateProfile(UpdateProfileDTO.Request)
    case validatePassword(ValidatePasswordDTO.Request)
    case resetPassword(ResetPasswordDTO.Request)
    case unregister
    case logout
}
