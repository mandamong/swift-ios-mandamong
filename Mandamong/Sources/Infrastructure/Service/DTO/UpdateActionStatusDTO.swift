//
//  UpdateActionStatusDTO.swift
//  Mandamong
//
//  Created by Swain Yun on 9/9/25.
//

import Foundation

enum UpdateActionStatusDTO {
    struct Request: Encodable {
        let status: StatusDTO
    }
}

extension UpdateActionStatusDTO.Request {
    enum StatusDTO: String, Encodable {
        case inProgress = "IN_PROGRESS"
        case done = "DONE"
    }
}
