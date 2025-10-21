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
    /// 만다라트 표시 옵션
    ///
    /// - Note: AppStorage 사용을 위해 `String` 원시값을 갖습니다.
    enum PresentationMode: String {
        case list, grid
    }
    
    @ObservableState
    struct State: Equatable {
        var mandarat: Mandarat
        
        var mandaratChartFeatureState: MandaratChartFeature.State
        var mandaratListFeatureState: MandaratListFeature.State
        
        @Shared(.appStorage(AppStorageKey.mandaratPresentationMode)) var mode: PresentationMode = .grid
        
        init(mandarat: Mandarat) {
            self.mandarat = mandarat
            mandaratChartFeatureState = .init(mandarat: mandarat)
            mandaratListFeatureState = .init(mandarat: mandarat)
        }
    }
    
    @CasePathable
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case mandaratChartFeatureAction(MandaratChartFeature.Action)
        case mandaratListFeatureAction(MandaratListFeature.Action)
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        
        Scope(state: \.mandaratChartFeatureState, action: \.mandaratChartFeatureAction) { MandaratChartFeature() }
        Scope(state: \.mandaratListFeatureState, action: \.mandaratListFeatureAction) { MandaratListFeature() }
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .mandaratChartFeatureAction:
                return .none
                
            case .mandaratListFeatureAction:
                return .none
            }
        }
    }
}
