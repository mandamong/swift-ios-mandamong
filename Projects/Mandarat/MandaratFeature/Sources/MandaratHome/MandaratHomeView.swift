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
    private enum Constants {
        static let createIconName: String = "plus"
        static let deleteIconName: String = "trash"
        static let cellContentSpacing: CGFloat = 30
        static let cellCornerRadius: CGFloat = 8
        static let cellBackgroundOpacity: CGFloat = 0.4
    }
    
    let store: StoreOf<MandaratHomeFeature> = .init(initialState: MandaratHomeFeature.State()) { MandaratHomeFeature() }
    
    public var body: some View {
        NavigationStackStore(store.scope(state: \.path, action: \.path)) {
            ZStack(alignment: .bottomTrailing) {
                GeometryReader { proxy in
                    List {
                        ForEach(store.mandarats) { mandarat in
                            NavigationLink(state: MandaratHomeFeature.Path.State.mandaratDetailFeatureState(.init(mandarat: mandarat))) {
                                cell(mandarat, width: proxy.size.width)
                            }
                            .listRowSeparator(.hidden)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    store.send(.view(.swipeToDelete(mandarat.id)))
                                } label: {
                                    Label(Mandamong.Strings.Common.delete, systemImage: Constants.deleteIconName)
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                }
                
                Button {
                    // TODO: 만다라트 생성 기능 추가
                } label: {
                    Image(systemName: Constants.createIconName)
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
            VStack(alignment: .leading, spacing: Constants.cellContentSpacing) {
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
            RoundedRectangle(cornerRadius: Constants.cellCornerRadius)
                .fill(.mandamongBackground)
                .shadow(color: .mandamongSecondary.opacity(Constants.cellBackgroundOpacity), radius: Constants.cellCornerRadius, y: 10)
        )
    }
}

#Preview {
    NavigationStack {
        MandaratHomeView()
    }
}
