//
//  MandaratCellView.swift
//  MandaratFeature
//
//  Created by SwainYun on 10/12/25.
//

import SwiftUI
import MandaratDomain
import DesignSystem

struct MandaratCellView: View {
    /// 뷰의 스타일과 관련된 상수 값을 관리하는 이름 공간입니다.
    private enum Style {
        static let cornerRadius: CGFloat = 10
        static let groupMemberLineLimit: Int = 3
    }
    
    /// 뷰의 투명도와 관련된 상수 값을 관리하는 이름 공간입니다.
    private enum Opacity {
        static let focusedSubject: Double = 0.8
        static let visibleObjective: Double = 0.7
        static let visibleAction: Double = 0.6
        static let inactive: Double = 0.3
        static let placeholder: Double = 0.2
    }
    
    let info: CellInfo
    let isFocused: Bool
    let isGroupMember: Bool
    let namespace: Namespace.ID
    let activeSize: CGFloat
    let inactiveSize: CGFloat
    
    private var id: UInt { info.id }
    
    private var dataSource: MandaratDataSource { info.dataSource }
    
    private var isVisible: Bool { isFocused || isGroupMember }
    
    private var size: CGFloat { isVisible ? activeSize : inactiveSize }
    
    private var backgroundColor: Color {
        switch dataSource {
        case .subject: .yellow.opacity(isFocused ? Opacity.focusedSubject : Opacity.inactive)
        case .objective: .blue.opacity(isVisible ? Opacity.visibleObjective : Opacity.inactive)
        case .actionIdea: .green.opacity(isVisible ? Opacity.visibleAction : Opacity.inactive)
        case .placeholder: .mandamongSecondary.opacity(Opacity.placeholder)
        }
    }
    
    var body: some View {
        Text(isVisible ? dataSource.content : "")
            .frame(width: size, height: size)
            .mandamongFont(isFocused ? .cellCore : .cellIdea)
            .multilineTextAlignment(.center)
            .lineLimit(isFocused ? nil : Style.groupMemberLineLimit)
            .background(
                RoundedRectangle(cornerRadius: Style.cornerRadius)
                    .fill(backgroundColor)
            )
            .matchedGeometryEffect(id: id, in: namespace)
    }
}
