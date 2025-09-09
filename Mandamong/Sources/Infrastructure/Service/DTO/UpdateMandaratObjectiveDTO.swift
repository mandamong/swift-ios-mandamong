//
//  UpdateMandaratObjectiveDTO.swift
//  Mandamong
//
//  Created by Swain Yun on 9/9/25.
//

import Foundation

enum UpdateMandaratObjectiveDTO {
    struct Request: Encodable {
        let objective: String
        
        enum CodingKeys: String, CodingKey {
            case objective = "newObjective"
        }
    }
    
    struct Response: Decodable {
        let id: Int
        let objective: String
        let status: StatusDTO
        
        enum CodingKeys: String, CodingKey {
            case id, status
            case objective = "name"
        }
    }
}

extension UpdateMandaratObjectiveDTO.Response {
    enum StatusDTO: String, Decodable {
        case inProgress = "IN_PROGRESS"
        case done = "DONE"
    }
}
