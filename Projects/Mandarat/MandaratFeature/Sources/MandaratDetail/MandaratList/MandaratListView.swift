//
//  MandaratListView.swift
//  MandaratFeature
//
//  Created by SwainYun on 10/14/25.
//

import SwiftUI
import ComposableArchitecture
import MandaratDomain
import DesignSystem

struct MandaratListView: View {
    @Bindable var store: StoreOf<MandaratListFeature>
    
    init(store: StoreOf<MandaratListFeature>) {
        self.store = store
    }
    
    var body: some View {
        List {
            Section(Mandamong.Strings.Mandarat.subject) {
                cellLabel(store.mandarat.subject.content, completionRate: store.mandarat.completionRate)
            }

            Section(Mandamong.Strings.Mandarat.objective) {
                ForEach($store.mandarat.objectives) { $objective in
                    DisclosureGroup {
                        ForEach($objective.actionItems) { $actionIdea in
                            Toggle(isOn: $actionIdea.isCompleted) {
                                Text(actionIdea.action)
                                    .strikethrough(actionIdea.isCompleted)
                                    .foregroundStyle(actionIdea.isCompleted ? .mandamongSecondary : .mandamongPrimary)
                            }
                        }
                    } label: {
                        cellLabel(objective.content, completionRate: objective.completionRate)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func cellLabel(_ title: String, completionRate: CompletionRate) -> some View {
        VStack {
            HStack {
                Text(title)
                
                Spacer()
                
                StatusTagView(rate: completionRate)
            }
            
            ProgressView(value: completionRate).progressViewStyle(.stick)
        }
    }
}

#Preview {
    MandaratListView(store: .init(initialState: MandaratListFeature.State.init(mandarat: .mock), reducer: { MandaratListFeature() }))
}
