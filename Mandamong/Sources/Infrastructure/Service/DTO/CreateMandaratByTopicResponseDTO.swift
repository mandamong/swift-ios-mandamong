//
//  CreateMandaratByTopicResponseDTO.swift
//  Mandamong
//
//  Created by Swain Yun on 9/8/25.
//

import Foundation

enum CreateMandaratByTopicDTO {
    struct Request: Encodable {
        let subject: String
    }
    
    struct Response: Decodable {
        let objectives: [String] // SubGoals
        let actions: [[String]] // ActionItems
    }
}
