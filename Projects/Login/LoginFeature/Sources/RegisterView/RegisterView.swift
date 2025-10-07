//
//  RegisterView.swift
//  LoginFeature
//
//  Created by SwainYun on 10/4/25.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem

struct RegisterView: View {
    @Bindable var store: StoreOf<RegisterFeature>
    @FocusState private var focusState: RegisterFeature.State.Field?
    
    var body: some View {
        VStack(spacing: 20) {
            Text(Mandamong.Strings.Register.title)
                .mandamongFont(.primary)
            
            Text(Mandamong.Strings.Register.subtitle)
                .mandamongFont(.caption)
            
            FloatingTitleTextField(title: Mandamong.Strings.Register.emailPlaceholder, text: $store.email, focused: $store.focusedField, equals: .email)
                .focused($focusState, equals: .email)
            
            FloatingTitleTextField(title: Mandamong.Strings.Register.nicknamePlaceholder, text: $store.nickname, focused: $store.focusedField, equals: .nickname)
                .focused($focusState, equals: .nickname)
            
            FloatingTitleTextField(title: Mandamong.Strings.Register.passwordPlaceholder, text: $store.password, focused: $store.focusedField, equals: .password, isSecure: true)
                .focused($focusState, equals: .password)
            
            FloatingTitleTextField(title: Mandamong.Strings.Register.passwordConfirmationPlaceholder, text: $store.passwordConfirmation, focused: $store.focusedField, equals: .passwordConfirmation, isSecure: true)
                .focused($focusState, equals: .passwordConfirmation)
            
            Button {
                store.send(.view(.registerButtonTapped))
            } label: {
                Text(Mandamong.Strings.Register.registerButtonTitle)
                    .mandamongFont(.primary)
                    .foregroundStyle(.white)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.mandamongPrimary)
                    }
            }
            
            Button {
                store.send(.view(.loginButtonTapped))
            } label: {
                Text(Mandamong.Strings.Register.switchToLoginButtonTitle)
                    .underline()
            }
            .onChange(of: store.focusedField) { _, newValue in
                focusState = newValue
            }
            .onChange(of: focusState) { _, newValue in
                store.send(.binding(.set(\.focusedField, newValue)))
            }
        }
        .padding()
    }
}

#Preview {
    RegisterView(store: .init(initialState: RegisterFeature.State(), reducer: { RegisterFeature() }))
}
