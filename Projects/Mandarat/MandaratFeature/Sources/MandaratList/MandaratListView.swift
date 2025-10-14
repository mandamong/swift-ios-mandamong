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

public struct MandaratListView: View {
    @Bindable var store: StoreOf<MandaratListFeature>
    
    public init(store: StoreOf<MandaratListFeature>) {
        self.store = store
    }
    
    public var body: some View {
        List {
            Section(Mandamong.Strings.Mandarat.subject) {
                Text(store.mandarat.subject.content)
            }
            
            Section(Mandamong.Strings.Mandarat.objective) {
                ForEach($store.mandarat.objectives) { $objective in
                    DisclosureGroup {
                        ForEach($objective.actionItems) { $actionIdea in
                            Toggle(isOn: $actionIdea.isCompleted) {
                                Text(actionIdea.action)
                                    .strikethrough(actionIdea.isCompleted, color: .secondary)
                            }
                        }
                    } label: {
                        Text(objective.content)
                    }
                }
            }
        }
        .navigationTitle(store.mandarat.title)
    }
}

#Preview {
    NavigationStack {
        MandaratListView(store: .init(initialState: MandaratListFeature.State.init(mandarat: .mock), reducer: { MandaratListFeature() }))
    }
}
