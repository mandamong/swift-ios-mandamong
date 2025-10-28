//
//  MandaratEditView.swift
//  MandaratFeature
//
//  Created by SwainYun on 10/22/25.
//

import SwiftUI
import ComposableArchitecture
import MandaratDomain
import DesignSystem

private typealias StringLiterals = Mandamong.Strings

struct MandaratEditView: View {
    @Bindable var store: StoreOf<MandaratEditFeature>
    
    var body: some View {
        NavigationStack {
            VStack {
                switch store.step {
                case .editing:
                    editingView
                    
                case .confirmingCascade:
                    confirmingCascadeView
                }
            }
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { toolbarContent }
        }
    }
    
    private var editingView: some View {
        Form {
            Section("수정할 내용") {
                TextField("내용 입력", text: $store.content, axis: .vertical)
                    .lineLimit(3...)
            }
        }
    }
    
    private var confirmingCascadeView: some View {
        VStack(spacing: 20) {
            Text("하위 요소도 함께 수정할까요?")
            
            Button {
                store.send(.view(.tapConfirmCascadeWithChildrenButton))
            } label: {
                Text("하위 요소도 함께 수정")
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                store.send(.view(.tapConfirmCascadeOnlyButton))
            } label: {
                Text("이 요소만 수정")
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
    
    private var navigationTitle: String {
        switch store.target {
        case .subject: "핵심 주제 수정"
        case .objective: "목표 수정"
        case .actionIdea: "행동 아이디어 수정"
        }
    }
    
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        if case .editing = store.step {
            ToolbarItem(placement: .cancellationAction) {
                Button(StringLiterals.Common.cancel) {
                    store.send(.view(.tapCancelButton))
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button(StringLiterals.Common.save) {
                    store.send(.view(.tapSaveButton))
                }
                .disabled(store.content.isEmpty)
            }
        }
    }
}

#Preview {
    MandaratEditView(store: .init(initialState: MandaratEditFeature.State(target: .subject(id: 1, currentContent: "current content")), reducer: { MandaratEditFeature() }))
}
