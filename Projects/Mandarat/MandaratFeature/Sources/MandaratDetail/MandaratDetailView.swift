//
//  MandaratDetailView.swift
//  MandaratFeature
//
//  Created by SwainYun on 10/19/25.
//

import SwiftUI
import ComposableArchitecture
import MandaratDomain
import DesignSystem

// TODO: 만다라트 상세 화면 구현(목록형, 그리드형 보기 옵션 전환 등)
struct MandaratDetailView: View {
    @Bindable var store: StoreOf<MandaratDetailFeature>
    
    var body: some View {
        VStack(spacing: 10) {
            Text("만다라트 상세 화면")
                .mandamongFont(.title)
            
            Text(store.mandarat.title)
            
            Text(store.mandarat.subject.content)
        }
    }
}

#Preview {
    MandaratDetailView(store: .init(initialState: MandaratDetailFeature.State(mandarat: .mock), reducer: { MandaratDetailFeature() }))
}
