//
//  MandamongTextStyle.swift
//  Mandamong
//
//  Created by Swain Yun on 9/7/25.
//

import SwiftUI

extension View {
    /// 디자인가이드에 정의된 폰트 텍스트스타일을 적용합니다.
    func mandamongFont(_ style: MandamongTextStyle) -> some View {
        modifier(TextStyleModifier(style: style))
    }
}

struct TextStyleModifier: ViewModifier {
    let style: MandamongTextStyle
    
    private var lineSpacing: CGFloat { (style.fontSize * style.lineHeight) - style.fontSize }
    private var tracking: CGFloat { style.fontSize * style.letterSpacing }
    
    func body(content: Content) -> some View {
        content
            .font(.custom(style.customFontName, size: style.fontSize))
            .fontWeight(style.fontWeight)
            .lineSpacing(lineSpacing)
            .tracking(tracking)
    }
}

enum MandamongTextStyle {
    case title
    case subtitle
    case primaryBody
    case secondaryBody
    case buttonLarge
    case buttonDefault
    case caption
    
    var fontSize: CGFloat {
        switch self {
        case .title: 32
        case .subtitle: 24
        case .primaryBody: 20
        case .secondaryBody: 18
        case .buttonLarge: 18
        case .buttonDefault: 16
        case .caption: 14
        }
    }
    
    var fontWeight: Font.Weight {
        switch self {
        case .title: .bold
        case .subtitle: .medium
        case .primaryBody: .bold
        case .secondaryBody: .regular
        case .buttonLarge: .medium
        case .buttonDefault: .medium
        case .caption: .bold
        }
    }
    
    var lineHeight: CGFloat {
        1.4
    }
    
    var letterSpacing: CGFloat {
        switch self {
        case .caption: 0
        default: -0.02
        }
    }
    
    var customFontName: String {
        switch self {
        case .title, .primaryBody, .caption: "SpocaHanSansNeo-Bold"
        case .subtitle, .buttonLarge, .buttonDefault: "SpocaHanSansNeo-Medium"
        case .secondaryBody: "SpocaHanSansNeo-Regular"
        }
    }
}
