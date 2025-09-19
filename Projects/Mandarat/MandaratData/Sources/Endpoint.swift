//
//  Endpoint.swift
//  MandaratData
//
//  Created by Swain Yun on 9/18/25.
//

import Foundation

enum MandaratEndpoint {
    // MARK: - Tokens required
    case createMandaratBySubject(CreateMandaratBySubjectDTO.Request)
    case createActionsByObjective(CreateActionsByObjective.Request)
    case saveMandarat(SaveMandaratDTO.Request)
    case updateMandaratTitle(id: Int, UpdateMandaratTitleDTO.Request)
    case updateMandaratSubject(id: Int, UpdateMandaratSubjectDTO.Request)
    case updateMandaratObjective(id: Int, UpdateMandaratObjectiveDTO.Request)
    case updateMandaratAction(id: Int, UpdateMandaratActionDTO.Request)
    case updateActionStatus(id: Int, UpdateActionStatusDTO.Request)
    case readMandaratList(number: Int?, size: Int?)
    case readMandaratDetail(id: Int)
    case deleteMandarat(id: Int)
}
