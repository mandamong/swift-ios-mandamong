//
//  LoginFeature.swift
//  LoginFeature
//
//  Created by SwainYun on 10/4/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct LoginFeature {
    @ObservableState
    struct State: Equatable {
        enum Field: Hashable { case email, password }
        
        var email: String = ""
        var password: String = ""
        var focusedField: Field?
    }
    
    @CasePathable
    enum Action: BindableAction {
        enum ViewAction {
            case loginButtonTapped
            case registerButtonTapped
            case adjustPasswordButtonTapped
        }
        
        enum DelegateAction {
            case switchToRegister
            case switchToAdjustPassword
        }
        
        case view(ViewAction)
        case binding(BindingAction<State>)
        case delegate(DelegateAction)
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .view(.loginButtonTapped):
                return .none
                
            case .view(.registerButtonTapped):
                return .send(.delegate(.switchToRegister))
                
            case .view(.adjustPasswordButtonTapped):
                return .send(.delegate(.switchToAdjustPassword))
                
            case .binding(\.email):
                return .none
                
            case .binding(\.password):
                return .none
            
            default:
                return .none
            }
        }
    }
}
