//
//  MandaratListFeature.swift
//  MandaratFeature
//
//  Created by SwainYun on 10/14/25.
//

import Foundation
import ComposableArchitecture
import MandaratDomain

@Reducer
struct MandaratListFeature {
    @ObservableState
    struct State: Equatable {
        var mandarat: Mandarat
        
        init(mandarat: Mandarat) {
            self.mandarat = mandarat
        }
    }
    
    @CasePathable
    enum Action: BindableAction {
        enum ViewAction {
            // TODO: 액션 추가
            case actionIdeaCompletionToggled(objectiveID: UInt, actionIdeaID: UInt)
        }
        
        case view(ViewAction)
        case binding(BindingAction<State>)
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
    }
}
