//
//  UpdateMandaratSubjectDTO.swift
//  Mandamong
//
//  Created by Swain Yun on 9/9/25.
//

import Foundation

enum UpdateMandaratSubjectDTO {
    struct Request: Encodable {
        let subject: String
        
        enum CodingKeys: String, CodingKey {
            case subject = "newSubject"
        }
    }
    
    struct Response: Decodable {
        let id: Int
        let subject: String
        let status: StatusDTO
    }
}

extension UpdateMandaratSubjectDTO.Response {
    enum StatusDTO: String, Decodable {
        case inProgress = "IN_PROGRESS"
        case done = "DONE"
    }
}
