//
//  ReadMandaratListDTO.swift
//  Mandamong
//
//  Created by Swain Yun on 9/8/25.
//

import Foundation

enum ReadMandaratListDTO {
    struct Response: Decodable {
        let totalPage: Int
        let hasNext: Bool
        let content: [MandaratSummaryDTO]
    }
}

extension ReadMandaratListDTO.Response {
    struct MandaratSummaryDTO: Decodable {
        let id: Int
        let name: String
        let subject: String
        let status: String
    }
}
