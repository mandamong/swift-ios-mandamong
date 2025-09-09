//
//  RootView.swift
//  Mandamong
//
//  Created by Swain Yun on 9/7/25.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct RootFeature {
    @ObservableState
    struct State: Equatable {
        
    }
}

struct RootView: View {
    @State private var isPresented: Bool = false
    
    
    var body: some View {
        NavigationStack {
            MandaratView()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("만다몽")
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isPresented.toggle()
                        } label: {
                            Image(systemName: "moon")
                        }
                    }
                    
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button {
                            
                        } label: {
                            Text("로그인")
                        }
                        
                        Button {
                            
                        } label: {
                            Text("회원가입")
                        }
                        .buttonStyle(.prominent)
                    }
                }
        }
    }
}

#Preview {
    RootView()
}
