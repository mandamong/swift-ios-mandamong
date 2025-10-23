//
//  MandaratDetailFeature.swift
//  MandaratFeature
//
//  Created by SwainYun on 10/19/25.
//

import ComposableArchitecture
import MandaratDomain

@Reducer
struct MandaratDetailFeature {
    /// 만다라트 표시 옵션
    ///
    /// - Note: AppStorage 사용을 위해 `String` 원시값을 갖습니다.
    enum PresentationMode: String {
        case list, grid
    }
    
    @ObservableState
    struct State: Equatable {
        var mandarat: Mandarat
        
        var mandaratChartFeatureState: MandaratChartFeature.State
        var mandaratListFeatureState: MandaratListFeature.State
        
        @Shared(.appStorage(AppStorageKey.mandaratPresentationMode)) var mode: PresentationMode = .grid
        
        @Presents var mandaratEditFeatureState: MandaratEditFeature.State?
        
        init(mandarat: Mandarat) {
            self.mandarat = mandarat
            mandaratChartFeatureState = .init(mandarat: mandarat)
            mandaratListFeatureState = .init(mandarat: mandarat)
        }
    }
    
    @CasePathable
    enum Action: BindableAction {
        enum ViewAction {
            case tapDeleteButton
            case tapEditSubjectButton(Subject)
            case tapEditObjectiveButton(Objective)
            case tapEditActionIdeaButton(ActionIdea)
        }
        
        enum DelegateAction {
            case deleteMandarat(Mandarat.ID)
            case didUpdateMandarat(Mandarat)
        }
        
        case view(ViewAction)
        case delegate(DelegateAction)
        case binding(BindingAction<State>)
        case mandaratChartFeatureAction(MandaratChartFeature.Action)
        case mandaratListFeatureAction(MandaratListFeature.Action)
        case mandaratEditFeatureAction(PresentationAction<MandaratEditFeature.Action>)
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        
        Scope(state: \.mandaratChartFeatureState, action: \.mandaratChartFeatureAction) { MandaratChartFeature() }
        Scope(state: \.mandaratListFeatureState, action: \.mandaratListFeatureAction) { MandaratListFeature() }
        
        Reduce { state, action in
            switch action {
            case .view(.tapDeleteButton):
                return .send(.delegate(.deleteMandarat(state.mandarat.id)))
                
            case let .view(.tapEditSubjectButton(subject)):
                state.mandaratEditFeatureState = .init(target: .subject(id: subject.id, currentContent: subject.content))
                return .none
                
            case let .view(.tapEditObjectiveButton(objective)):
                state.mandaratEditFeatureState = .init(target: .objective(id: objective.id, currentContent: objective.content))
                return .none
                
            case let .view(.tapEditActionIdeaButton(actionIdea)):
                state.mandaratEditFeatureState = .init(target: .actionIdea(id: actionIdea.id, currentContent: actionIdea.action))
                return .none
                
            case let .mandaratEditFeatureAction(.presented(.delegate(.saveCompleted(target, newContent, cascade)))):
                updateMandaratElement(mandarat: &state.mandarat, target: target, newContent: newContent, cascade: cascade)
                state.mandaratChartFeatureState.mandarat = state.mandarat
                state.mandaratListFeatureState.mandarat = state.mandarat
                return .send(.delegate(.didUpdateMandarat(state.mandarat)))
                
            case .delegate, .binding, .mandaratChartFeatureAction, .mandaratListFeatureAction, .mandaratEditFeatureAction:
                return .none
            }
        }
        .ifLet(\.$mandaratEditFeatureState, action: \.mandaratEditFeatureAction) { MandaratEditFeature() }
    }
    
    // TODO: 추후 MandaratRepository 인터페이스 사용
    // 임시 Helper Method
    private func updateMandaratElement(
        mandarat: inout Mandarat,
        target: MandaratEditFeature.EditTarget,
        newContent: String,
        cascade: Bool
    ) {
        switch target {
        case let .subject(id, _):
            guard mandarat.subject.id == id else { return }
            mandarat.subject.content = newContent
            
            guard cascade else { return }
            mandarat.objectives = mandarat.objectives.map { objective in
                var newObjective = objective
                newObjective.content = "temp-objective"
                newObjective.actionItems = newObjective.actionItems.map { actionIdea in
                    var newActionIdea = actionIdea
                    newActionIdea.action = "temp-action-idea"
                    newActionIdea.isCompleted = false
                    return newActionIdea
                }
                return newObjective
            }
            
        case let .objective(id, _):
            guard let objectiveIndex = mandarat.objectives.firstIndex(where: { $0.id == id }) else { return }
            mandarat.objectives[objectiveIndex].content = newContent
            
            guard cascade else { return }
            mandarat.objectives[objectiveIndex].actionItems = mandarat.objectives[objectiveIndex].actionItems.map { actionIdea in
                var newActionIdea = actionIdea
                newActionIdea.action = "temp-action-idea"
                newActionIdea.isCompleted = false
                return newActionIdea
            }
            
        case let .actionIdea(id, _):
            guard let objectiveIndex = mandarat.objectives.firstIndex(where: { $0.actionItems.contains(where: { $0.id == id }) }),
                  let actionIdeaIndex = mandarat.objectives[objectiveIndex].actionItems.firstIndex(where: { $0.id == id })
            else { return }
            mandarat.objectives[objectiveIndex].actionItems[actionIdeaIndex].action = newContent
        }
    }
}
