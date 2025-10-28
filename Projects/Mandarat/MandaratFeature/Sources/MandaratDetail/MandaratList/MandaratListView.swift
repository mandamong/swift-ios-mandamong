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

private typealias StringLiterals = Mandamong.Strings

struct MandaratListView: View {
    private enum Constants {
        static let editIconName: String = "pencil"
    }
    
    @Bindable var store: StoreOf<MandaratListFeature>
    
    let onEditSubject: (Subject) -> Void
    let onEditObjective: (Objective) -> Void
    let onEditActionIdea: (ActionIdea) -> Void
    
    init(
        store: StoreOf<MandaratListFeature>,
        onEditSubject: @escaping (Subject) -> Void,
        onEditObjective: @escaping (Objective) -> Void,
        onEditActionIdea: @escaping (ActionIdea) -> Void
    ) {
        self.store = store
        self.onEditSubject = onEditSubject
        self.onEditObjective = onEditObjective
        self.onEditActionIdea = onEditActionIdea
    }
    
    var body: some View {
        List {
            Section(Mandamong.Strings.Mandarat.subject) {
                cellLabel(store.mandarat.subject.content, completionRate: store.mandarat.completionRate)
                    .contentShape(.rect)
                    .onLongPressGesture { onEditSubject(store.mandarat.subject) }
                    .swipeActions(edge: .leading) {
                        Button {
                            onEditSubject(store.mandarat.subject)
                        } label: {
                            Label(StringLiterals.Common.edit, systemImage: Constants.editIconName)
                        }
                        .tint(.blue)
                    }
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
                            .onLongPressGesture { onEditActionIdea(actionIdea) }
                            .swipeActions(edge: .leading) {
                                Button {
                                    onEditActionIdea(actionIdea)
                                } label: {
                                    Label(StringLiterals.Common.edit, systemImage: Constants.editIconName)
                                }
                                .tint(.blue)
                            }
                        }
                    } label: {
                        cellLabel(objective.content, completionRate: objective.completionRate)
                            .onLongPressGesture { onEditObjective(objective) }
                            .swipeActions(edge: .leading) {
                                Button {
                                    onEditObjective(objective)
                                } label: {
                                    Label(StringLiterals.Common.edit, systemImage: Constants.editIconName)
                                }
                                .tint(.blue)
                            }
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
    MandaratListView(store: .init(initialState: MandaratListFeature.State.init(mandarat: .mock), reducer: { MandaratListFeature() })) { _ in
        ()
    } onEditObjective: { _ in
        ()
    } onEditActionIdea: { _ in
        ()
    }
}
