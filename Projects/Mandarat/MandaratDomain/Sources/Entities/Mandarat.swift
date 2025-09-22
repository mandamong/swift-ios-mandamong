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
    
    init(id: UInt, action: String = String(), isCompleted: Bool = false) {
        self.id = id
        self.action = action
        self.isCompleted = isCompleted
    }
}

/// 핵심 주제별 목표
struct Objective: Identifiable {
    let id:  UInt
    var content: String
    var actionItems: [ActionItem]
    
    init(id: UInt, content: String = String(), actionItems: [ActionItem] = []) {
        self.id = id
        self.content = content
        self.actionItems = actionItems
    }
}

/// 핵심 주제
struct Subject: Identifiable {
    let id: UInt
    var content: String
    var isCompleted: Bool
    
    init(id: UInt, content: String = String(), isCompleted: Bool = false) {
        self.id = id
        self.content = content
        self.isCompleted = isCompleted
    }
}

/// 만다라트 차트
struct Mandarat: Identifiable {
    let id: UInt
    var title: String
    var subject: Subject
    var objectives: [Objective]
    var createdAt: Date
    
    init(id: UInt, title: String, subject: Subject, objectives: [Objective], createdAt: Date = .now) {
        self.id = id
        self.title = title
        self.subject = subject
        self.objectives = objectives
        self.createdAt = createdAt
    }
}
