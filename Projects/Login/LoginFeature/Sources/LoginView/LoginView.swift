//
//  LoginView.swift
//  LoginFeature
//
//  Created by SwainYun on 10/3/25.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem

struct LoginView: View {
    @Bindable var store: StoreOf<LoginFeature>
    @FocusState private var focusState: LoginFeature.State.Field?
    
    var body: some View {
        VStack(spacing: 20) {
            Text(Mandamong.Strings.Login.title)
                .mandamongFont(.primary)
            
            Text(Mandamong.Strings.Login.subtitle)
                .mandamongFont(.caption)
            
            FloatingTitleTextField(title: Mandamong.Strings.Login.emailPlaceholder, text: $store.email, focused: $store.focusedField, equals: .email)
                .focused($focusState, equals: .email)
            
            FloatingTitleTextField(title: Mandamong.Strings.Login.passwordPlaceholder, text: $store.password, focused: $store.focusedField, equals: .password, isSecure: true)
                .focused($focusState, equals: .password)
            
            Button {
                store.send(.view(.loginButtonTapped))
            } label: {
                Text(Mandamong.Strings.Login.loginButtonTitle)
                    .mandamongFont(.primary)
                    .foregroundStyle(.white)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.mandamongPrimary)
                    }
            }
            
            HStack {
                Button {
                    store.send(.view(.registerButtonTapped))
                } label: {
                    Text(Mandamong.Strings.Login.switchToRegisterButtonTitle)
                        .underline()
                }
                
                Spacer()
                
                Button {
                    store.send(.view(.adjustPasswordButtonTapped))
                } label: {
                    Text(Mandamong.Strings.Login.switchToAdjustPasswordButtonTitle)
                        .underline()
                }
            }
        }
        .onChange(of: store.focusedField) { _, newValue in
            focusState = newValue
        }
        .onChange(of: focusState) { _, newValue in
            store.send(.binding(.set(\.focusedField, newValue)))
        }
        .padding()
    }
}
