//
//  StatusTagView.swift
//  MandaratFeature
//
//  Created by SwainYun on 10/15/25.
//

import SwiftUI
import DesignSystem

public enum StatusTagStyle {
    case label
    case completionRate
}

private struct StatusTagStyleKey: EnvironmentKey {
    typealias Value = StatusTagStyle
    static let defaultValue: Value = .label
}

extension EnvironmentValues {
    var tagStyle: StatusTagStyle {
        get { self[StatusTagStyleKey.self] }
        set { self[StatusTagStyleKey.self] = newValue }
    }
}

// MARK: - View + Helper Methods
public extension View where Self == StatusTagView {
    func tagStyle(_ style: StatusTagStyle) -> some View {
        self.environment(\.tagStyle, style)
    }
}

public struct StatusTagView: View {
    public typealias CompletionRate = Double
    private struct Constants {
        static let completed = "완료"
        static let progress = "진행 중"
        static let gradientOpacity: CGFloat = 0.6
    }
    
    @Environment(\.tagStyle) private var style
    
    private let rate: CompletionRate
    
    public init(rate: CompletionRate) {
        self.rate = rate
    }
    
    public var body: some View {
        switch style {
        case .label:
            labelView()
        case .completionRate:
            completionRateView()
        }
    }
    
    @ViewBuilder
    private func labelView() -> some View {
        let isCompleted: Bool = (rate >= 1.0)
        let text: String = isCompleted ? Constants.completed : Constants.progress
        let backgroundGradient = LinearGradient(
            colors: isCompleted ? [.green.opacity(Constants.gradientOpacity), .green] : [.mandamongPrimary.opacity(Constants.gradientOpacity), .mandamongPrimary],
            startPoint: .bottomLeading,
            endPoint: .topTrailing
        )
        
        Text(text)
            .mandamongFont(.caption)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .foregroundStyle(.white)
            .background(backgroundGradient)
            .clipShape(.capsule)
    }
    
    @ViewBuilder
    private func completionRateView() -> some View {
        let percentageText: String = .init(format: "%0.0f%%", rate * 100)
        
        Text(percentageText)
            .mandamongFont(.caption)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .foregroundStyle(.white)
            .background(
                Capsule()
                    .fill(.mandamongSecondary)
                    .strokeBorder(.mandamongPrimary)
            )
            .clipShape(.capsule)
    }
}

#Preview {
    StatusTagView(rate: 0.534)
    
    StatusTagView(rate: 1.0)
    
    StatusTagView(rate: 0.534)
        .tagStyle(.completionRate)
    
    StatusTagView(rate: 1)
        .tagStyle(.completionRate)
}
