//
//  UpdateMandaratActionDTO.swift
//  Mandamong
//
//  Created by Swain Yun on 9/9/25.
//

import Foundation

enum UpdateMandaratActionDTO {
    struct Request: Encodable {
        let action: String
        
        enum CodingKeys: String, CodingKey {
            case action = "newAction"
        }
    }
    
    struct Response: Decodable {
        let id: Int
        let action: String
        let status: StatusDTO
        
        enum CodingKeys: String, CodingKey {
            case id, status
            case action = "name"
        }
    }
}

extension UpdateMandaratActionDTO.Response {
    enum StatusDTO: String, Decodable {
        case inProgress = "IN_PROGRESS"
        case done = "DONE"
    }
}
