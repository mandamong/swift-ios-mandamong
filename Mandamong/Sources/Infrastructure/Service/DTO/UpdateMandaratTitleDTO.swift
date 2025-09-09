//
//  UpdateMandaratTitleDTO.swift
//  Mandamong
//
//  Created by Swain Yun on 9/9/25.
//

import Foundation

enum UpdateMandaratTitleDTO {
    struct Request: Encodable {
        let title: String
        
        enum CodingKeys: String, CodingKey {
            case title = "newMandalartName"
        }
    }
    
    struct Response: Decodable {
        let id: Int
        let title: String
        let status: StatusDTO
        
        enum CodingKeys: String, CodingKey {
            case id, status
            case title = "name"
        }
    }
}

extension UpdateMandaratTitleDTO.Response {
    enum StatusDTO: String, Decodable {
        case inProgress = "IN_PROGRESS"
        case done = "DONE"
    }
}
