//
//  MandaratChartFeature.swift
//  MandaratFeature
//
//  Created by SwainYun on 10/11/25.
//

import ComposableArchitecture
import MandaratDomain

@Reducer
public struct MandaratChartFeature {
    /// 차트에서 강조될 그룹을 의미합니다.
    public enum ChartFocus: Hashable, Equatable {
        /// 핵심 주제가 강조된 상태
        case subject
        /// 특정 목표와 행동 아이디어들이 강조된 상태
        case objective(id: UInt)
    }
    
    @ObservableState
    public struct State: Equatable {
        public var mandarat: Mandarat
        public var cellInfos: [CellInfo]
        public var focus: ChartFocus = .subject
        
        public init(mandarat: Mandarat) {
            self.mandarat = mandarat
            self.cellInfos = MandaratGridGenerator.generate(for: mandarat)
        }
    }
    
    @CasePathable
    public enum Action {
        public enum ViewAction {
            case cellTapped(MandaratDataSource)
        }
        
        case view(ViewAction)
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .view(.cellTapped(dataSource)):
                updateFocus(for: dataSource, in: &state)
                return .none
            }
        }
    }
}

// MARK: - MandaratChartFeature + Helper Methods
private extension MandaratChartFeature {
    /**
     사용자가 탭한 셀 데이터에 따라 강조 상태를 갱신합니다.
     - Parameters:
        - dataSource: 사용자가 탭한 셀의 데이터 소스.
        - state: 변경할 현재 `State`
     */
    func updateFocus(for dataSource: MandaratDataSource, in state: inout State) {
        switch dataSource {
        case .subject:
            state.focus = .subject
        case .objective(let objective):
            state.focus = .objective(id: objective.id)
        case .actionIdea(let actionIdea):
            guard let superObjective = state.mandarat.objectives.first(where: { $0.actionItems.contains(where: { $0.id == actionIdea.id }) }) else { return }
            state.focus = .objective(id: superObjective.id)
            
        case .placeholder:
            // TODO: 빈 셀일 때는 만다라트 요소 추가 등의 작업 (WIP)
            return
        }
    }
}
