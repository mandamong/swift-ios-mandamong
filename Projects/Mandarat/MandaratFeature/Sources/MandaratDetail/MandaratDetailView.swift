//
//  MandaratDetailView.swift
//  MandaratFeature
//
//  Created by SwainYun on 10/19/25.
//

import SwiftUI
import ComposableArchitecture
import MandaratDomain
import DesignSystem

private typealias PresentationMode = MandaratDetailFeature.PresentationMode

struct MandaratDetailView: View {
    private struct Constants {
        static let modePickerTitle: String = "만다라트 표시 옵션"
        static let gridIconName: String = "rectangle.split.2x2.fill"
        static let listIconName: String = "list.bullet"
        static let deleteIconName: String = "trash"
    }
    
    @Bindable var store: StoreOf<MandaratDetailFeature>
    
    var body: some View {
        VStack {
            switch store.mode {
            case .grid:
                MandaratChartView(store: store.scope(state: \.mandaratChartFeatureState, action: \.mandaratChartFeatureAction))
                
            case .list:
                MandaratListView(store: store.scope(state: \.mandaratListFeatureState, action: \.mandaratListFeatureAction))
            }
        }
        .navigationTitle(store.mandarat.title)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button(role: .destructive) {
                    store.send(.view(.tapDeleteButton))
                } label: {
                    Image(systemName: Constants.deleteIconName)
                }
                .accessibilityLabel(Mandamong.Strings.Common.delete)
                
                Picker(Constants.modePickerTitle, selection: $store.mode) {
                    Image(systemName: Constants.gridIconName)
                        .tag(PresentationMode.grid)
                        .accessibilityLabel(Mandamong.Strings.Common.grid)
                    
                    Image(systemName: Constants.listIconName)
                        .tag(PresentationMode.list)
                        .accessibilityLabel(Mandamong.Strings.Common.list)
                }
                .pickerStyle(.segmented)
            }
        }
    }
}

#Preview {
    NavigationStack {
        MandaratDetailView(store: .init(initialState: MandaratDetailFeature.State(mandarat: .mock), reducer: { MandaratDetailFeature() }))
    }
}
