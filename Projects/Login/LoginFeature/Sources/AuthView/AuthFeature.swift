//
//  AuthFeature.swift
//  LoginFeature
//
//  Created by SwainYun on 10/4/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AuthFeature {
    @ObservableState
    struct State: Equatable {
        enum AuthStep {
            case login, register, adjustPassword
        }
        
        var currentStep: AuthStep = .login
        var loginFeatureState:  LoginFeature.State = .init()
        var registerFeatureState: RegisterFeature.State = .init()
    }
    
    @CasePathable
    enum Action {
        case loginFeatureAction(LoginFeature.Action)
        case registerFeatureAction(RegisterFeature.Action)
    }
    
    var body: some Reducer<State, Action> {
        Scope(state: \.loginFeatureState, action: \.loginFeatureAction) { LoginFeature() }
        Scope(state: \.registerFeatureState, action: \.registerFeatureAction) { RegisterFeature() }
        
        Reduce { state, action in
            switch action {
            case .loginFeatureAction(.delegate(.switchToRegister)):
                state.currentStep = .register
                return .none
                
            case .loginFeatureAction(.delegate(.switchToAdjustPassword)):
                state.currentStep = .adjustPassword
                return .none
                
            case .registerFeatureAction(.delegate(.switchToLogin)):
                state.currentStep = .login
                return .none
                
            default:
                return .none
            }
        }
    }
}
