//
//  ReusableDTO.swift
//  MandaratData
//
//  Created by Swain Yun on 9/18/25.
//

import Foundation

struct ActionDTO: Decodable {
    let id: Int
    let action: String
    let status: StatusDTO
}

enum StatusDTO: String, Codable {
    case inProgress = "IN_PROGRESS"
    case done = "DONE"
}

struct MandaratDTO: Decodable {
    let id: Int
    let name: String
    let status: StatusDTO
}

struct ObjectiveDTO: Decodable {
    let id: Int
    let name: String
    let status: StatusDTO
}

struct SubjectDTO: Decodable {
    let id: Int
    let name: String
    let status: StatusDTO
}
