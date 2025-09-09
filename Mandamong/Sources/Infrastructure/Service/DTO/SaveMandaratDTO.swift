//
//  SaveMandaratDTO.swift
//  Mandamong
//
//  Created by Swain Yun on 9/9/25.
//

import Foundation

enum SaveMandaratDTO {
    struct Request: Encodable {
        let name, subject: String
        let objectives: [String]
        let actions: [[String]]
    }
    
    struct Response: Decodable {
        let mandalart: MandalartDTO
        let subject: SubjectDTO
        let objectives: [ObjectiveDTO]
        let actions: [[ActionDTO]]
    }
}

extension SaveMandaratDTO.Response {
    struct ActionDTO: Decodable {
        let id: Int
        let action: String
        let status: StatusDTO
    }

    enum StatusDTO: String, Decodable {
        case inProgress = "IN_PROGRESS"
        case done = "DONE"
    }

    struct MandalartDTO: Decodable {
        let id: Int
        let mandalartName: String
        let status: StatusDTO
    }

    struct ObjectiveDTO: Decodable {
        let id: Int
        let objective: String
        let status: StatusDTO
    }

    struct SubjectDTO: Decodable {
        let id: Int
        let subject: String
        let status: StatusDTO
    }
}
