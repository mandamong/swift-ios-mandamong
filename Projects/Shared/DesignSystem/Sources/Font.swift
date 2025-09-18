//
//  Font.swift
//  Shared
//
//  Created by Swain Yun on 9/17/25.
//

import SwiftUI

public enum TextStyle {
    case title, subtitle, caption
    case primary, secondary
    case buttonLarge, buttonDefault
    case cellCore, cellSub, cellIdea
    
    var fontSize: CGFloat {
        switch self {
        case .title: 32
        case .subtitle: 24
        case .primary: 20
        case .secondary, .buttonLarge: 18
        case .buttonDefault: 16
        case .caption: 14
        case .cellCore, .cellSub, .cellIdea: 10
        }
    }
    
    var fontWeight: Font.Weight {
        switch self {
        case .title, .primary, .caption, .cellCore: .bold
        case .subtitle, .buttonLarge, .buttonDefault, .cellSub, .cellIdea: .medium
        case .secondary: .regular
        }
    }
    
    var lineHeight: CGFloat {
        switch self {
        case .title, .subtitle, .primary, .secondary, .caption, .buttonLarge, .buttonDefault: 1.4
        case .cellCore, .cellSub, .cellIdea: 1.2
        }
    }
    
    var letterSpacing: CGFloat {
        switch self {
        case .caption: 0
        default: -0.02
        }
    }
    
    var fontName: String {
        switch self {
        case .title, .primary, .caption, .cellCore: "SpoqaHanSansNeo-Bold"
        case .subtitle, .buttonLarge, .buttonDefault, .cellSub, .cellIdea: "SpoqaHanSansNeo-Medium"
        case .secondary: "SpoqaHanSansNeo-Regular"
        }
    }
}

struct TextStyleModifier: ViewModifier {
    public let style: TextStyle
    
    public init(style: TextStyle) {
        self.style = style
    }
    
    private var calculatedLineSpacing: CGFloat { (style.fontSize * style.lineHeight) - style.fontSize }
    private var calculatedTracking: CGFloat { style.fontSize * style.letterSpacing }
    
    func body(content: Content) -> some View {
        content
            .font(.custom(style.fontName, size: style.fontSize))
            .fontWeight(style.fontWeight)
            .lineSpacing(calculatedLineSpacing)
            .tracking(calculatedTracking)
    }
}

public extension View {
    func mandamongFont(_ style: TextStyle) -> some View {
        modifier(TextStyleModifier(style: style))
    }
}
