//
//  UpdateActionStatusDTO.swift
//  MandaratData
//
//  Created by Swain Yun on 9/18/25.
//

import Foundation

enum UpdateActionStatusDTO {
    struct Request: Encodable {
        let status: StatusDTO
    }
}
