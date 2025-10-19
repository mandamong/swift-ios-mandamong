//
//  MandaratHomeView.swift
//  MandaratFeature
//
//  Created by SwainYun on 10/18/25.
//

import SwiftUI
import MandaratDomain
import ComposableArchitecture
import DesignSystem

public struct MandaratHomeView: View {
    let store: StoreOf<MandaratHomeFeature> = .init(initialState: MandaratHomeFeature.State()) { MandaratHomeFeature() }
    
    public var body: some View {
        NavigationStackStore(store.scope(state: \.path, action: \.path)) {
            ZStack(alignment: .bottomTrailing) {
                GeometryReader { proxy in
                    ScrollView(.vertical) {
                        LazyVStack(spacing: 30) {
                            ForEach(store.mandarats) { mandarat in
                                NavigationLink(state: MandaratHomeFeature.Path.State.mandaratDetailFeatureState(.init(mandarat: mandarat))) {
                                    cell(mandarat, width: proxy.size.width)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
                
                Button {
                    // TODO: 만다라트 생성 기능 추가
                } label: {
                    Image(systemName: "plus")
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .navigationTitle(Mandamong.Strings.Mandarat.mandarat)
        } destination: { store in
            switch store.state {
            case .mandaratDetailFeatureState:
                if let mandaratDetailStore = store.scope(state: \.mandaratDetailFeatureState, action: \.mandaratDetailFeatureAction) {
                    MandaratDetailView(store: mandaratDetailStore)
                }
            }
        }
    }
}

// MARK: - MandaratHomeView + Subviews
private extension MandaratHomeView {
    @ViewBuilder
    func cell(_ mandarat: Mandarat, width: CGFloat) -> some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text(mandarat.title)
                
                Text(mandarat.subject.content)
                    .mandamongFont(.caption)
            }
            .lineLimit(2)
            .multilineTextAlignment(.leading)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                HStack {
                    StatusTagView(rate: mandarat.completionRate).tagStyle(.label)
                    StatusTagView(rate: mandarat.completionRate).tagStyle(.completionRate)
                }
                
                ProgressView(value: mandarat.completionRate).progressViewStyle(.stick)
            }
            .frame(maxWidth: width / 3)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.mandamongBackground)
                .shadow(color: .mandamongSecondary.opacity(0.4), radius: 10, y: 10)
        )
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        MandaratHomeView()
    }
}
