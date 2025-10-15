//
//  Mandarat.swift
//  MandaratDomain
//
//  Created by Swain Yun on 9/22/25.
//

import Foundation

public typealias CompletionRate = Double

/// 목표별 행동 아이디어
public struct ActionIdea: Identifiable, Hashable {
    public let id: UInt
    public var action: String
    public var isCompleted: Bool
    
    public init(id: UInt, action: String, isCompleted: Bool) {
        self.id = id
        self.action = action
        self.isCompleted = isCompleted
    }
}

/// 핵심 주제별 목표
public struct Objective: Identifiable, Hashable {
    public let id:  UInt
    public var content: String
    public var actionItems: [ActionIdea]
    public var completionRate: CompletionRate {
        guard actionItems.isEmpty == false else { return .zero }
        let completedCount = actionItems.filter { $0.isCompleted }.count
        return Double(completedCount) / Double(actionItems.count)
    }
    
    public init(id: UInt, content: String, actionItems: [ActionIdea]) {
        self.id = id
        self.content = content
        self.actionItems = actionItems
    }
}

/// 핵심 주제
public struct Subject: Identifiable, Hashable {
    public let id: UInt
    public var content: String
    public var isCompleted: Bool
    
    public init(id: UInt, content: String, isCompleted: Bool) {
        self.id = id
        self.content = content
        self.isCompleted = isCompleted
    }
}

/// 만다라트 차트
public struct Mandarat: Identifiable, Hashable {
    public let id: UInt
    public var title: String
    public var subject: Subject
    public var objectives: [Objective]
    public let createdAt: Date
    public var completionRate: CompletionRate {
        let actionIdeas = objectives.flatMap { $0.actionItems }
        guard actionIdeas.isEmpty == false else { return .zero }
        let completedCount = actionIdeas.filter { $0.isCompleted }.count
        return Double(completedCount) / Double(actionIdeas.count)
    }
    
    public init(id: UInt, title: String, subject: Subject, objectives: [Objective], createdAt: Date = .now) {
        self.id = id
        self.title = title
        self.subject = subject
        self.objectives = objectives
        self.createdAt = createdAt
    }
}

// MARK: - Mandarat + Mock
extension Mandarat {
    public static let mock = Mandarat(
        id: 1,
        title: "SwiftUI 마스터하기",
        subject: Subject(id: 100, content: "SwiftUI 정복", isCompleted: false),
        objectives: [
            Objective(id: 201, content: "기본기", actionItems: [
                ActionIdea(id: 301, action: "View와 Modifier", isCompleted: false),
                ActionIdea(id: 302, action: "Layout 시스템", isCompleted: false),
                ActionIdea(id: 303, action: "State 관리 기초", isCompleted: false),
                ActionIdea(id: 304, action: "Preview 활용", isCompleted: false),
                ActionIdea(id: 305, action: "SF Symbols", isCompleted: false)
            ]),
            Objective(id: 202, content: "상태 관리", actionItems: [
                ActionIdea(id: 401, action: "@StateObject", isCompleted: false),
                ActionIdea(id: 402, action: "@ObservedObject", isCompleted: false),
                ActionIdea(id: 403, action: "@EnvironmentObject", isCompleted: false),
                ActionIdea(id: 404, action: "Binding", isCompleted: false),
                ActionIdea(id: 405, action: "데이터 흐름 이해", isCompleted: false)
            ]),
            Objective(id: 203, content: "고급 UI", actionItems: [
                ActionIdea(id: 501, action: "Custom View", isCompleted: false),
                ActionIdea(id: 502, action: "Animation", isCompleted: false),
                ActionIdea(id: 503, action: "Gesture", isCompleted: false),
                ActionIdea(id: 504, action: "Navigation", isCompleted: false),
                ActionIdea(id: 505, action: "MatchedGeometry", isCompleted: false)
            ]),
            Objective(id: 204, content: "앱 배포", actionItems: [
                ActionIdea(id: 601, action: "App Store Connect", isCompleted: false),
                ActionIdea(id: 602, action: "인증서 관리", isCompleted: false),
                ActionIdea(id: 603, action: "TestFlight", isCompleted: false),
                ActionIdea(id: 604, action: "앱 아이콘/스샷", isCompleted: false),
                ActionIdea(id: 605, action: "버전 관리", isCompleted: false)
            ])
        ]
    )
}
