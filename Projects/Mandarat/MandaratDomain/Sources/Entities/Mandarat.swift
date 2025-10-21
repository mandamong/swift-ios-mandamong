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

/// 만다라트 도메인 규칙
public enum MandaratRules {
    /// 만다라트가 가질 수 있는 최대 목표(`Objectvie`) 개수입니다.
    public static let maxObjectives: Int = 4
    /// 하나의 목표가 가질 수 있는 최대 행동 아이디어(`ActionIdea`) 개수입니다.
    public static let maxActionIdeas: Int = 5
}

// MARK: - Mandarat + Mock
extension Mandarat {
    public static let mock = Mandarat(
        id: 1,
        title: "SwiftUI 마스터하기",
        subject: Subject(id: 100, content: "SwiftUI 정복", isCompleted: false),
        objectives: [
            Objective(id: 201, content: "기본기", actionItems: [
                ActionIdea(id: 301, action: "View와 Modifier", isCompleted: true),
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
            ]),
        ],
        createdAt: Date().addingTimeInterval(-86400 * 3)
    )

    public static let mockCompleted = Mandarat(
        id: 2,
        title: "건강한 식습관 만들기",
        subject: Subject(id: 200, content: "매일 건강식", isCompleted: true),
        objectives: [
            Objective(id: 701, content: "아침", actionItems: [
                ActionIdea(id: 801, action: "물 마시기", isCompleted: true),
                ActionIdea(id: 802, action: "샐러드 먹기", isCompleted: true)
            ]),
            Objective(id: 702, content: "점심", actionItems: [
                ActionIdea(id: 803, action: "단백질 섭취", isCompleted: true),
                ActionIdea(id: 804, action: "가공식품 피하기", isCompleted: true)
            ]),
            Objective(id: 703, content: "저녁", actionItems: [
                ActionIdea(id: 805, action: "가볍게 먹기", isCompleted: true),
                ActionIdea(id: 806, action: "채소 위주", isCompleted: true)
            ]),
            Objective(id: 704, content: "간식", actionItems: []),
        ],
        createdAt: Date().addingTimeInterval(-86400 * 7)
    )

    public static let mockInProgress = Mandarat(
        id: 3,
        title: "블로그 포스팅",
        subject: Subject(id: 300, content: "주 2회 포스팅", isCompleted: false),
        objectives: [
            Objective(id: 901, content: "아이디어", actionItems: [
                ActionIdea(id: 1001, action: "브레인스토밍", isCompleted: true),
                ActionIdea(id: 1002, action: "키워드 리서치", isCompleted: true)
            ]),
            Objective(id: 902, content: "초안 작성", actionItems: [
                ActionIdea(id: 1003, action: "1번 포스트 초안", isCompleted: true),
                ActionIdea(id: 1004, action: "2번 포스트 초안", isCompleted: false)
            ]),
            Objective(id: 903, content: "발행", actionItems: [
                ActionIdea(id: 1005, action: "1번 포스트 발행", isCompleted: false),
                ActionIdea(id: 1006, action: "2번 포스트 발행", isCompleted: false)
            ]),
            Objective(id: 904, content: "홍보", actionItems: []),
        ],
        createdAt: Date().addingTimeInterval(-86400 * 2)
    )

    public static let mockNew = Mandarat(
        id: 4,
        title: "새로운 프로젝트 구상",
        subject: Subject(id: 400, content: "신규 앱 기획", isCompleted: false),
        objectives: [
            Objective(id: 1101, content: "시장 조사", actionItems: [
                ActionIdea(id: 1201, action: "경쟁 앱 분석", isCompleted: false),
                ActionIdea(id: 1202, action: "타겟 유저 정의", isCompleted: false)
            ]),
            Objective(id: 1102, content: "기능 정의", actionItems: [
                ActionIdea(id: 1203, action: "MVP 기능 목록", isCompleted: false)
            ]),
            Objective(id: 1103, content: "수익 모델", actionItems: []),
            Objective(id: 1104, content: "기술 스택", actionItems: [
                ActionIdea(id: 1204, action: "SwiftUI + TCA", isCompleted: false)
            ]),
        ],
        createdAt: Date()
    )

    public static let mocks: [Mandarat] = [
        .mock,
        .mockCompleted,
        .mockInProgress,
        .mockNew
    ]
}
