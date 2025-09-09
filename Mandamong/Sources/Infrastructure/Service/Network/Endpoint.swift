//
//  Endpoint.swift
//  Mandamong
//
//  Created by Swain Yun on 9/7/25.
//

import Foundation
import Moya

enum Endpoint {
    // MARK: - Before-auth
    case checkNicknameDuplication(nickname: String)
    case checkEmailDuplication(email: String)
    case requestEmailAuthenticationCode(EmailAuthenticationCodeDTO.Request)
    case verifyEmail(email: String, code: String)
    case register(email: String, password: String, nickname: String, image: Data, languageID: String)
    case login(LoginDTO.Request)
    case reissueToken(ReissueTokenDTO.Request)
    
    // MARK: - After-auth
    case createMandaratWithTopic(CreateMandaratByTopicDTO.Request)
    case createActionsWithGoal(CreateActionWithGoalDTO.Request)
    case saveMandarat(SaveMandaratDTO.Request)
    case updateMandaratTitle(id: Int, UpdateMandaratTitleDTO.Request)
    case updateMandaratSubject(id: Int, UpdateMandaratSubjectDTO.Request)
    case updateMandaratObjective(id: Int, UpdateMandaratObjectiveDTO.Request)
    case updateMandaratAction(id: Int, UpdateMandaratActionDTO.Request)
    case updateActionStatus(id: Int, UpdateActionStatusDTO.Request)
    case readMandaratList(number: Int?, size: Int?)
    case readMandaratDetail(id: Int)
    case deleteMandarat(id: Int)
    
    var usingToken: Bool {
        switch self {
        case .checkNicknameDuplication, .checkEmailDuplication, .requestEmailAuthenticationCode, .verifyEmail, .register, .login, .reissueToken: return false
        default: return true
        }
    }
}

// MARK: - TargetType Conformation
//extension Endpoint: TargetType {
//    var baseURL: URL { URL(string: "https://mandamong-dev.sailin.cloud/api")! }
//    
//    var path: String {
//        <#code#>
//    }
//    
//    var method: Moya.Method {
//        <#code#>
//    }
//    
//    var task: Moya.Task {
//        <#code#>
//    }
//    
//    var headers: [String : String]? {
//        <#code#>
//    }
//}
