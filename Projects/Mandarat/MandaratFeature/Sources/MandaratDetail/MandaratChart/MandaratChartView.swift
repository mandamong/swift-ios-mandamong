//
//  MandaratChartView.swift
//  MandaratFeature
//
//  Created by SwainYun on 10/12/25.
//

import SwiftUI
import ComposableArchitecture
import MandaratDomain

private typealias ChartFocus = MandaratChartFeature.ChartFocus

struct MandaratChartView: View {
    /// 뷰에서 사용되는 상수 값을 관리하는 이름 공간입니다.
    private enum Constants {
        static let gridSpacing: CGFloat = 10
        static let gridRange = 0..<5
        static let horizontalPadding: CGFloat = 16
        
        enum Animation {
            static let extraBounce: CGFloat = 0.2
        }
        
        enum Sizing {
            static let activeUnit: CGFloat = 5.0
            static let inactiveUnit: CGFloat = 2.0
        }
    }
    
    @Bindable var store: StoreOf<MandaratChartFeature>
    @Namespace private var animation
    
    init(store: StoreOf<MandaratChartFeature>) {
        self.store = store
    }
    
    var body: some View {
        GeometryReader { proxy in
            let paddedViewSideLength = min(proxy.size.width, proxy.size.height)
            let gridContentWidth = max(0, paddedViewSideLength - (Constants.horizontalPadding * 2))
            let totalSpacing = Constants.gridSpacing * CGFloat(Constants.gridRange.count - 1)
            let cellAreaWidth = max(0, gridContentWidth - totalSpacing)
            let totalUnitsInWorstCase = (Constants.Sizing.activeUnit * 3) + (Constants.Sizing.inactiveUnit * 2)
            let unitPixelSize = cellAreaWidth / totalUnitsInWorstCase
            let activeSize = unitPixelSize * Constants.Sizing.activeUnit
            let inactiveSize = unitPixelSize * Constants.Sizing.inactiveUnit
            
            Grid(alignment: .center, horizontalSpacing: Constants.gridSpacing, verticalSpacing: Constants.gridSpacing) {
                ForEach(Constants.gridRange, id: \.self) { row in
                    GridRow {
                        ForEach(Constants.gridRange, id: \.self) { column in
                            if let info = cellInfo(atRow: row, atColumn: column) {
                                cell(for: info, activeSize: activeSize, inactiveSize: inactiveSize)
                            } else {
                                Color.clear
                            }
                        }
                    }
                }
            }
            .padding(Constants.horizontalPadding)
            .frame(width: paddedViewSideLength, height: paddedViewSideLength)
            .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
        }
    }
}

// MARK: - MandaratChartView + Helper Methods
private extension MandaratChartView {
    /**
     주어진 행과 열에 해당하는 `CellInfo`를 찾아서 반환합니다.
     - Parameters:
        - row: 찾고자 하는 셀의 행.
        - column: 찾고자 하는 셀의 열.
     - Returns: `CellInfo` 또는 해당하는 셀이 없을 경우 `nil`
     */
    func cellInfo(atRow row: Int, atColumn column: Int) -> CellInfo? {
        store.cellInfos.first { $0.row == row && $0.column == column }
    }
    
    /**
     주어진 데이터 소스와 현재 강조 상태를 기반으로 셀의 상태를 계산합니다.
     - Parameters:
        - dataSource: 상태를 계산할 셀의 데이터 소스.
        - focus: 현재 뷰의 강조 상태
     - Returns: 셀이 강조되었는지(`isFocused`), 그룹에 포함되는지(`isGroupMember`)를 나타내는 튜플.
     */
    func calculateCellStatus(for dataSource: MandaratDataSource, with focus: ChartFocus) -> (isFocused: Bool, isGroupMember: Bool) {
        switch focus {
        case .subject:
            guard case let .subject(subject) = dataSource else { return (false, false) }
            return (subject.id == store.mandarat.subject.id, false)
            
        case .objective(let focusedID):
            var isFocused: Bool = false
            var isGroupMember: Bool = false
            
            switch dataSource {
            case .objective(let objective):
                isFocused = (objective.id == focusedID)
                
            case .actionIdea(let actionIdea):
                guard let focusedObjective = store.mandarat.objectives.first(where: { $0.id == focusedID }) else { break }
                isGroupMember = focusedObjective.actionItems.contains { $0.id == actionIdea.id }
                
            default:
                break
            }
            
            return (isFocused, isGroupMember)
        }
    }
}

// MARK: - MandaratChartView + Subviews
private extension MandaratChartView {
    /// 주어진 `CellInfo`에 대한 `MandaratCellView`를 생성하고 구성합니다.
    @ViewBuilder
    func cell(
        for info: CellInfo,
        activeSize: CGFloat,
        inactiveSize: CGFloat
    ) -> some View {
        let (isFocused, isGroupMember) = calculateCellStatus(for: info.dataSource, with: store.focus)
        
        MandaratCellView(
            info: info,
            isFocused: isFocused,
            isGroupMember: isGroupMember,
            namespace: animation,
            activeSize: activeSize,
            inactiveSize: inactiveSize
        )
        .onTapGesture {
            let animation = Animation.bouncy(extraBounce: Constants.Animation.extraBounce)
            store.send(.view(.cellTapped(info.dataSource)), animation: animation)
        }
    }
}

#Preview {
    MandaratChartView(store: .init(initialState: MandaratChartFeature.State(mandarat: .mock), reducer: { MandaratChartFeature() }))
}
