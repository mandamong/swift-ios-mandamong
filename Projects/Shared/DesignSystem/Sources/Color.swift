//
//  Color.swift
//  Shared
//
//  Created by Swain Yun on 9/18/25.
//

import SwiftUI

public extension ShapeStyle where Self == Color {
    static var mandamongPrimary: Color { MandamongColor.primary.color }
    static var mandamongAccentColor: Color { MandamongColor.primary.color }
    static var mandamongBackground: Color { MandamongColor.background.color }
    static var mandamongSecondary: Color { MandamongColor.secondary.color }
    
    
    static func hex(_ hex: UInt, alpha: Double = 1) -> Self {
        .init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
    
    static func mandamongColor(_ type: MandamongColor) -> Self { type.color }
}

public enum MandamongColor: UInt {
    case primary = 0x7122FF
    case background = 0xFAFCFE
    case secondary = 0xBBBBBB
    
    fileprivate var color: Color { .hex(self.rawValue) }
}
