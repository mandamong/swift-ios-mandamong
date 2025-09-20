//
//  UpdateMandaratActionDTO.swift
//  MandaratData
//
//  Created by Swain Yun on 9/18/25.
//

import Foundation

enum UpdateMandaratActionDTO {
    struct Request: Encodable {
        let action: String
        
        enum CodingKeys: String, CodingKey {
            case action = "newAction"
        }
    }
    
    typealias Response = ActionDTO
}
