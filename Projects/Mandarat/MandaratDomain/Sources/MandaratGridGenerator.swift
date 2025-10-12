//
//  MandaratGridGenerator.swift
//  MandaratDomain
//
//  Created by SwainYun on 10/12/25.
//

import Foundation

/// 만다라트 데이터 모델을 기반으로 5x5 그리드 레이아웃 정보를 생성하는 역할을 맡은 타입입니다.
public struct MandaratGridGenerator {
    typealias Coordinate = (row: Int, column: Int)
    
    /// 그리드 레이아웃과 관련된 상수 값을 관리하는 이름 공간
    enum Layout {
        /// 그리드 내 객체의 상대적 위치
        enum ObjectPosition {
            case top, bottom, leading, trailing
        }
        /// 핵심 주제가 위치할 중앙 좌표
        static let center: Coordinate = (2, 2)
        /// 핵심 주제별 목표 4개가 위치할 좌표 배열 (중앙 좌표 기준으로 좌, 상, 우, 하 순서)
        static let objectivePositions: [Coordinate] = [(2, 1), (1, 2), (2, 3), (3, 2)]
        /// 목표별 행동 아이디어들이 위치할 좌표 딕셔너리
        static let actionIdeaPositions: [ObjectPosition: [Coordinate]] = [
            .top:      [(0, 0), (0, 1), (1, 0), (1, 1), (0, 2)],
            .bottom:   [(3, 3), (4, 3), (3, 4), (4, 4), (4, 2)],
            .leading:  [(3, 0), (4, 0), (3, 1), (4, 1), (2, 0)],
            .trailing: [(0, 3), (0, 4), (1, 3), (1, 4), (2, 4)],
        ]
    }
    
    /**
     주어진 `Mandarat` 데이터로부터 25개 셀의 위치 정보(`CellInfo`) 배열을 생성합니다.
     - Parameter mandarat: 그리드를 구성할 `Mandarat` 데이터 모델.
     - Returns: 각 셀의 위치와 데이터 정보를 담고 있는 `CellInfo` 배열.
     */
    public static func generate(for mandarat: Mandarat) -> [CellInfo] {
        let subjectInfo = CellInfo(dataSource: .subject(mandarat.subject), row: Layout.center.row, column: Layout.center.column)
        let otherInfos = Layout.objectivePositions.enumerated().flatMap { (index, position) -> [CellInfo] in
            guard let objectPosition = objectivePosition(at: position),
                  let actionPositions = Layout.actionIdeaPositions[objectPosition]
            else { return [] }
            
            if mandarat.objectives.indices.contains(index) {
                let objective = mandarat.objectives[index]
                let objectiveCell = CellInfo(dataSource: .objective(objective), row: position.row, column: position.column)
                let actionCells = actionPositions.enumerated().map { (index, position) -> CellInfo in
                    guard objective.actionItems.indices.contains(index) else { return CellInfo(dataSource: .placeholder, row: position.row, column: position.column) }
                    return CellInfo(dataSource: .actionIdea(objective.actionItems[index]), row: position.row, column: position.column)
                }
                
                return [objectiveCell] + actionCells
            } else {
                let objectivePlaceholder = CellInfo(dataSource: .placeholder, row: position.row, column: position.column)
                let actionPlaceholders = actionPositions.map { CellInfo(dataSource: .placeholder, row: $0.row, column: $0.column) }
                return [objectivePlaceholder] + actionPlaceholders
            }
        }
        
        return [subjectInfo] + otherInfos
    }
}

// MARK: - MandaratGridGenerator + Helper Methods
private extension MandaratGridGenerator {
    /**
     주어진 좌표에 해당하는 목표의 상대적 위치 (`ObjectPosition`)를 반환합니다.
     - Parameter Position: 확인할 목표 셀의 좌표
     - Returns: `ObjectPosition` 또는 유효하지 않은 경우 `nil`
     */
    static func objectivePosition(at position: Coordinate) -> Layout.ObjectPosition? {
        let relativePositions: [Layout.ObjectPosition] = [.leading, .top, .trailing, .bottom]
        guard let index = Layout.objectivePositions.firstIndex(where: { $0.row == position.row && $0.column == position.column }) else { return nil }
        return relativePositions[index]
    }
}

/**
 만다라트 그리드의 단일 셀에 대한 정보
 
 `Identifiable`을 준수하여 SwiftUI의 `ForEach` 구문에서 사용될 수 있습니다.
 */
public struct CellInfo: Identifiable, Equatable {
    /// 셀에 표시할 데이터
    public let dataSource: MandaratDataSource
    /// 그리드 내 행(row) 위치
    public let row: Int
    /// 그리드 내 열(column) 위치
    public let column: Int
    /// 고유 식별자
    ///
    /// - Note: 데이터 소스가 실제 데이터를 가질 경우 해당 데이터의 식별자를 사용하고,
    /// `.placeholder`일 경우 좌표를 기반으로 한 식별자를 생성하여 뷰 렌더링에 이용합니다.
    public var id: UInt {
        switch dataSource {
        case .subject(let subject): subject.id
        case .objective(let objective): objective.id
        case .actionIdea(let actionIdea): actionIdea.id
        case .placeholder: UInt(1000 + (row * 10) + column)
        }
    }
}

/**
 만다라트 차트 내 각 셀에 표시될 데이터 유형
 
 `Subject`, `Objective`, `ActionIdea` 등 서로 다른 모델을 통합하여 뷰에서 일관되게 처리할 수 있도록 도와줍니다.
 */
public enum MandaratDataSource: Equatable, Hashable {
    case subject(Subject)
    case objective(Objective)
    case actionIdea(ActionIdea)
    case placeholder
    
    /// 데이터 소스가 셀에 표시할 텍스트 컨텐츠입니다.
    public var content: String {
        switch self {
        case .subject(let item): return item.content
        case .objective(let item): return item.content
        case .actionIdea(let item): return item.action
        case .placeholder: return ""
        }
    }
}
