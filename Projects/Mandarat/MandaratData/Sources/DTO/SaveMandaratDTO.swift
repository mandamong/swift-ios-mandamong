//
//  SaveMandaratDTO.swift
//  MandaratData
//
//  Created by Swain Yun on 9/18/25.
//

import Foundation

enum SaveMandaratDTO {
    struct Request: Encodable {
        let name, subject: String
        let objectives: [String]
        let actions: [[String]]
    }
    
    struct Response: Decodable {
        let mandarat: MandaratDTO
        
        enum CodingKeys: String, CodingKey {
            case mandarat = "mandalart"
        }
    }
}
