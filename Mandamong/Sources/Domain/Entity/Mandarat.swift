//
//  Mandarat.swift
//  Mandamong
//
//  Created by Swain Yun on 9/8/25.
//

import Foundation
import SwiftData

/// 목표별 행동 아이디어
@Model
final class ActionItem {
    @Attribute(.unique) var id: Int
    var action: String
    var isCompleted: Bool
    
    init(id: Int, action: String = "", isCompleted: Bool = false) {
        self.id = id
        self.action = action
        self.isCompleted = isCompleted
    }
}

/// 핵심 주제별 목표
@Model
final class Objective {
    @Attribute(.unique) var id: Int
    var goal: String
    
    @Relationship(deleteRule: .cascade) var actionItem: [ActionItem] = []
    
    init(id: Int, goal: String = "") {
        self.id = id
        self.goal = goal
    }
}

/// 만다라트 차트
///
/// - Description:
///     - coreGoal: 핵심 주제 (예: "정보처리기사 취득하기")
@Model
final class Mandarat {
    @Attribute(.unique) var id: Int
    // TODO: 서버와 무결성 확인을 위한 식별자 필요한지 검토?
    var serverID: Int? = nil
    var title: String
    var subject: String
    
    @Relationship(deleteRule: .cascade) var subGoals: [Objective] = []
    var createdAt: Date
    
    init(id: Int, serverID: Int? = nil, title: String, subject: String, createdAt: Date = .now) {
        self.id = id
        self.serverID = serverID
        self.title = title
        self.subject = subject
        self.createdAt = createdAt
    }
}
