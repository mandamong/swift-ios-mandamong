//
//  MandaratHomeFeature.swift
//  MandaratFeature
//
//  Created by SwainYun on 10/18/25.
//

import ComposableArchitecture
import MandaratDomain

@Reducer
struct MandaratHomeFeature {
    @ObservableState
    struct State: Equatable {
        var mandarats: IdentifiedArrayOf<Mandarat>
        var path: StackState<Path.State> = .init()
        
        init(mandarats: IdentifiedArrayOf<Mandarat> = .init(uniqueElements: Mandarat.mocks)) {
            self.mandarats = mandarats
        }
    }
    
    @CasePathable
    enum Action: BindableAction {
        enum ViewAction {
            case swipeToDelete(Mandarat.ID)
        }
        
        case view(ViewAction)
        case binding(BindingAction<State>)
        case path(StackAction<Path.State, Path.Action>)
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case let .view(.swipeToDelete(id)):
                state.mandarats.remove(id: id)
                return .none
                
            case .view:
                return .none
                
            case .binding:
                return .none
                
            case let .path(.element(id: pathID, action: .mandaratDetailFeatureAction(.delegate(.deleteMandarat(mandaratID))))):
                state.mandarats.remove(id: mandaratID)
                state.path.pop(from: pathID)
                return .none
                
            case let .path(.element(id: _, action: .mandaratDetailFeatureAction(.delegate(.didUpdateMandarat(updatedMandarat))))):
                state.mandarats[id: updatedMandarat.id] = updatedMandarat
                return .none
                
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path) { Path() }
    }
}

// MARK: - MandaratHomeFeature + Path
extension MandaratHomeFeature {
    @Reducer
    struct Path {
        @ObservableState
        enum State: Equatable {
            case mandaratDetailFeatureState(MandaratDetailFeature.State)
        }
        
        @CasePathable
        enum Action {
            case mandaratDetailFeatureAction(MandaratDetailFeature.Action)
        }
        
        var body: some Reducer<State, Action> {
            Scope(state: \.mandaratDetailFeatureState, action: \.mandaratDetailFeatureAction) { MandaratDetailFeature() }
        }
    }
}
