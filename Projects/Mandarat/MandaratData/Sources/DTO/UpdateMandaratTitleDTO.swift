//
//  UpdateMandaratTitleDTO.swift
//  MandaratData
//
//  Created by Swain Yun on 9/18/25.
//

import Foundation

enum UpdateMandaratTitleDTO {
    struct Request: Encodable {
        let title: String
        
        enum CodingKeys: String, CodingKey {
            case title = "newMandalartName"
        }
    }
    
    typealias Response = MandaratDTO
}
