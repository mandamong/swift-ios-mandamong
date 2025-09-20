//
//  UpdateMandaratSubjectDTO.swift
//  MandaratData
//
//  Created by Swain Yun on 9/18/25.
//

import Foundation

enum UpdateMandaratSubjectDTO {
    struct Request: Encodable {
        let subject: String
        
        enum CodingKeys: String, CodingKey {
            case subject = "newSubject"
        }
    }
    
    typealias Response = SubjectDTO
}
