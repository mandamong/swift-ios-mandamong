//
//  CreateMandaratBySubjectDTO.swift
//  MandaratData
//
//  Created by Swain Yun on 9/18/25.
//

import Foundation

enum CreateMandaratBySubjectDTO {
    struct Request: Encodable {
        let subject: String
    }
    
    struct Response: Decodable {
        let objectives: [String]
        let actions: [[String]]
    }
}
