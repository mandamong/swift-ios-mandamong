//
//  StickProgressViewStyle.swift
//  MandaratFeature
//
//  Created by SwainYun on 10/15/25.
//

import SwiftUI

public struct StickProgressViewStyle: ProgressViewStyle {
    private struct Constants {
        static let defaultHeight: CGFloat = 4.0
        static let gradientOpacity: Double = 0.6
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? .zero
        let isCompleted = (fractionCompleted >= 1.0)
        let fillGradient = LinearGradient(
            colors: isCompleted ? [.green.opacity(Constants.gradientOpacity), .green] : [.mandamongPrimary.opacity(Constants.gradientOpacity), .mandamongPrimary],
            startPoint: .leading,
            endPoint: .trailing
        )
        let trackGradient = LinearGradient(
            colors: [.mandamongSecondary.opacity(Constants.gradientOpacity), .mandamongSecondary],
            startPoint: .leading,
            endPoint: .trailing
        )
        
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(trackGradient)
                
                Capsule()
                    .fill(fillGradient)
                    .frame(width: proxy.size.width * fractionCompleted)
                    .animation(.snappy, value: fractionCompleted)
            }
        }
        .frame(maxHeight: Constants.defaultHeight)
    }
}

// MARK: - View + Helper Methods
public extension ProgressViewStyle where Self == StickProgressViewStyle {
    static var stick: StickProgressViewStyle { .init() }
}

#Preview {
    VStack(spacing: 20) {
        ProgressView(value: 1)
            .progressViewStyle(.linear)
        
        ProgressView(value: 1)
            .progressViewStyle(.stick)
        
        ProgressView(value: 0.567)
            .progressViewStyle(.stick)
        
        ProgressView(value: 0.05)
            .progressViewStyle(.stick)
        
        ProgressView(value: 0)
            .progressViewStyle(.stick)
        
    }
    .padding()
}
