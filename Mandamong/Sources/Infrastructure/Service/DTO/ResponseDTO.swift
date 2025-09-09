//
//  ResponseDTO.swift
//  Mandamong
//
//  Created by Swain Yun on 9/7/25.
//

import Foundation

struct ResponseDTO<Payload: Decodable>: Decodable {
    let success: Bool
    let payload: Payload?
    let error: String?
}
