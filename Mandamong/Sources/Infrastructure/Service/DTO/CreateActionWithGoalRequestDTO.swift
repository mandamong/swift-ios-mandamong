//
//  CreateActionWithGoalRequestDTO.swift
//  Mandamong
//
//  Created by Swain Yun on 9/8/25.
//

import Foundation

enum CreateActionWithGoalDTO {
    struct Request: Encodable {
        let objective: String
    }
    
    struct Response: Decodable {
        let actions: [String]
    }
}
