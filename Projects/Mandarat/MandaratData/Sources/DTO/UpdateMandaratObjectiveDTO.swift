//
//  UpdateMandaratObjectiveDTO.swift
//  MandaratData
//
//  Created by Swain Yun on 9/18/25.
//

import Foundation

enum UpdateMandaratObjectiveDTO {
    struct Request: Encodable {
        let objective: String
        
        enum CodingKeys: String, CodingKey {
            case objective = "newObjective"
        }
    }
    
    typealias Response = ObjectiveDTO
}
