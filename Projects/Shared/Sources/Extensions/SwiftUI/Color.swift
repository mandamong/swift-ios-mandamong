//
//  Color.swift
//  Shared
//
//  Created by Swain Yun on 9/18/25.
//

import SwiftUI

extension Color {
    static let primary = MandamongColor.primary.color
    static let accentColor = MandamongColor.primary.color
    static let background = MandamongColor.background.color
    
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

enum MandamongColor: UInt {
    case primary = 0x7122FF
    case background = 0xFAFCFE
    
    var color: Color { .hex(self.rawValue) }
}
