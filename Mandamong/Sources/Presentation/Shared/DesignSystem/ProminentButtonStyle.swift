//
//  ProminentButtonStyle.swift
//  Mandamong
//
//  Created by Swain Yun on 9/7/25.
//

import SwiftUI

extension ButtonStyle where Self == ProminentButtonStyle {
    static var prominent: Self { .init() }
    static func prominent(isLoading: Bool) -> Self { .init(isLoading: isLoading) }
}

struct ProminentButtonStyle: ButtonStyle {
    var backgroundColor: Color = .blue
    var foregroundColor: Color = .white
    var cornerRadius: CGFloat = 12
    var isLoading: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .opacity(isLoading ? 0 : 1)
            .overlay {
                if isLoading {
                    ProgressView()
                }
            }
            .background(backgroundColor)
            .foregroundStyle(foregroundColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .scaleEffect(configuration.isPressed && isLoading == false ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed || isLoading)
    }
}

extension ButtonStyle where Self == ReversedProminentButtonStyle {
    static var reversedProminent: Self { .init() }
    static func reversedProminent(isLoading: Bool) -> Self { .init(isLoading: isLoading) }
}

struct ReversedProminentButtonStyle: ButtonStyle {
    var foregroundColor: Color = .blue
    var cornerRadius: CGFloat = 12
    var lineWidth: CGFloat = 1.5
    var isLoading: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .foregroundStyle(foregroundColor)
            .opacity(isLoading ? 0 : 1)
            .overlay {
                if isLoading {
                    ProgressView()
                } else {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .strokeBorder(foregroundColor, lineWidth: lineWidth)
                }
            }
            .background(configuration.isPressed && isLoading == false ? foregroundColor.opacity(0.1) : .clear)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .scaleEffect(configuration.isPressed && isLoading == false ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed || isLoading)
    }
}
