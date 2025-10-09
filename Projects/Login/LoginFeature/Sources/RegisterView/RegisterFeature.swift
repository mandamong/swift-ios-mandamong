//
//  RegisterFeature.swift
//  LoginFeature
//
//  Created by SwainYun on 10/4/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct RegisterFeature {
    @ObservableState
    struct State: Equatable {
        enum Field: Hashable { case email, nickname, password, passwordConfirmation }
        
        var email: String = ""
        var nickname: String = ""
        var password: String = ""
        var passwordConfirmation: String = ""
        var focusedField: Field?
    }
    
    @CasePathable
    enum Action: BindableAction {
        enum ViewAction {
            case registerButtonTapped
            case loginButtonTapped
        }
        
        enum DelegateAction {
            case switchToLogin
        }
        
        case view(ViewAction)
        case binding(BindingAction<State>)
        case delegate(DelegateAction)
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .view(.registerButtonTapped):
                return .none
                
            case .view(.loginButtonTapped):
                return .send(.delegate(.switchToLogin))
                
            default:
                return .none
            }
        }
    }
}
