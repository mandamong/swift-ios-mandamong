//
//  ResponseDTO.swift
//  Network
//
//  Created by Swain Yun on 9/18/25.
//

import Foundation

// MARK: - ResponseDTO
public struct ResponseDTO<Payload: Decodable>: Decodable {
    public let success: Bool
    public let payload: Payload?
    public let error: ErrorDTO?
}

// MARK: - ErrorDTO
public struct ErrorDTO: Decodable {
    public let code: String
    public let message: String
}
