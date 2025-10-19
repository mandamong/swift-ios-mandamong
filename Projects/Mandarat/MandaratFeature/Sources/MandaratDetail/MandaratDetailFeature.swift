//
//  MandaratDetailFeature.swift
//  MandaratFeature
//
//  Created by SwainYun on 10/19/25.
//

import ComposableArchitecture
import MandaratDomain

@Reducer
struct MandaratDetailFeature {
    @ObservableState
    struct State: Equatable {
        var mandarat: Mandarat
    }
    
    @CasePathable
    enum Action {
        
    }
    
    var body: some Reducer<State, Action> {
        
    }
}
