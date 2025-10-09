//
//  AuthView.swift
//  LoginFeature
//
//  Created by SwainYun on 10/4/25.
//

import SwiftUI
import ComposableArchitecture

struct AuthView: View {
    let store: StoreOf<AuthFeature>
    
    var body: some View {
        ZStack {
            switch store.currentStep {
            case .login:
                LoginView(store: store.scope(state: \.loginFeatureState, action: \.loginFeatureAction))
                
            case .register:
                RegisterView(store: store.scope(state: \.registerFeatureState, action: \.registerFeatureAction))
                
            case .adjustPassword:
                Text("비밀번호 찾기")
            }
        }
    }
}

#Preview {
    AuthView(store: .init(initialState: AuthFeature.State(), reducer: { AuthFeature() }))
}
