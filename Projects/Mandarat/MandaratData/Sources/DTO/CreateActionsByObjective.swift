//
//  CreateActionsByObjective.swift
//  MandaratData
//
//  Created by Swain Yun on 9/18/25.
//

import Foundation

enum CreateActionsByObjective {
    struct Request: Encodable {
        let objective: String
    }
    
    struct Response: Decodable {
        let actions: [String]
    }
}
