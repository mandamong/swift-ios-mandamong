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
public struct MandaratListFeature {
    @ObservableState
    public struct State: Equatable {
        public var mandarat: Mandarat
        
        public init(mandarat: Mandarat) {
            self.mandarat = mandarat
        }
    }
    
    @CasePathable
    public enum Action: BindableAction {
        public enum ViewAction {
            // TODO: 액션 추가
            case actionIdeaCompletionToggled(objectiveID: UInt, actionIdeaID: UInt)
        }
        
        case view(ViewAction)
        case binding(BindingAction<State>)
    }
    
    public var body: some Reducer<State, Action> {
        BindingReducer()
    }
}
