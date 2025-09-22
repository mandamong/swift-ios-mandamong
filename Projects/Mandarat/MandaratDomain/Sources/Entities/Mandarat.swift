//
//  Mandarat.swift
//  MandaratDomain
//
//  Created by Swain Yun on 9/22/25.
//

import Foundation

/// 목표별 행동 아이디어
struct ActionItem: Identifiable {
    let id: UInt
    var action: String
    var isCompleted: Bool
}

/// 핵심 주제별 목표
struct Objective: Identifiable {
    let id:  UInt
    var content: String
    var actionItems: [ActionItem]
}

/// 핵심 주제
struct Subject: Identifiable {
    let id: UInt
    var content: String
    var isCompleted: Bool
}

/// 만다라트 차트
struct Mandarat: Identifiable {
    let id: UInt
    var title: String = ""
    var subject: Subject
    var objectives: [Objective]
    let createdAt: Date = .now
}
