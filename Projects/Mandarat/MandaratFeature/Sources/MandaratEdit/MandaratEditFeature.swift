//
//  MandaratEditFeature.swift
//  MandaratFeature
//
//  Created by SwainYun on 10/22/25.
//

import ComposableArchitecture
import MandaratDomain

@Reducer
struct MandaratEditFeature {
    /// 수정 대상 구분
    enum EditTarget: Equatable {
        case subject(id: Subject.ID, currentContent: String)
        case objective(id: Objective.ID, currentContent: String)
        case actionIdea(id: ActionIdea.ID, currentContent: String)
    }
    
    /// 수정 단계
    enum Step {
        /// 수정 단계
        case editing
        /// Cascade Rule 적용 확인 단계
        case confirmingCascade
    }
    
    @ObservableState
    struct State: Equatable {
        let target: EditTarget
        var content: String
        var step: Step = .editing
        
        init(target: EditTarget) {
            self.target = target
            switch target {
            case .subject(_, let content), .objective(_, let content), .actionIdea(_, let content):
                self.content = content
            }
        }
    }
    
    @CasePathable
    enum Action: BindableAction {
        enum ViewAction {
            case tapCancelButton
            case tapSaveButton
            case tapConfirmCascadeOnlyButton
            case tapConfirmCascadeWithChildrenButton
        }
        
        enum DelegateAction {
            case saveCompleted(target: EditTarget, newContent: String, cascade: Bool)
        }
        
        case view(ViewAction)
        case delegate(DelegateAction)
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .view(.tapCancelButton):
                return .run { _ in await dismiss() }
                
            case .view(.tapSaveButton):
                guard state.content.isEmpty == false else { return .none }
                
                switch state.target {
                case .actionIdea:
                    return .run { [content = state.content, target = state.target] send in
                        await send(.delegate(.saveCompleted(target: target, newContent: content, cascade: false)))
                        await dismiss()
                    }
                    
                case .subject, .objective:
                    state.step = .confirmingCascade
                    return .none
                }
                
            case .view(.tapConfirmCascadeOnlyButton):
                return .run { [content = state.content, target = state.target] send in
                    await send(.delegate(.saveCompleted(target: target, newContent: content, cascade: false)))
                    await dismiss()
                }
                
            case .view(.tapConfirmCascadeWithChildrenButton):
                return .run { [content = state.content, target = state.target] send in
                    await send(.delegate(.saveCompleted(target: target, newContent: content, cascade: true)))
                    await dismiss()
                }
                
            case .binding, .delegate:
                return .none
            }
        }
    }
}
