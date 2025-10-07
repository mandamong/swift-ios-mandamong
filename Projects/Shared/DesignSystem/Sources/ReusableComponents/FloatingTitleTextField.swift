//
//  FloatingTitleTextField.swift
//  DesignSystem
//
//  Created by SwainYun on 10/3/25.
//

import SwiftUI

public struct FloatingTitleTextField<FocusType: Hashable>: View {
    @Binding var text: String
    @Binding var focused: FocusType?
    
    let title: String
    var isSecure: Bool
    private let focusType: FocusType
    
    private var isFocused: Bool { focused == focusType }
    private var isTitleFloating: Bool { text.isEmpty == false || isFocused }
    
    public init(title: String, text: Binding<String>, focused: Binding<FocusType?>, equals focusType: FocusType, isSecure: Bool = false) {
        self.title = title
        self._text = text
        self._focused = focused
        self.focusType = focusType
        self.isSecure = isSecure
    }
    
    public var body: some View {
        ZStack(alignment: .leading) {
            Group {
                if isSecure {
                    SecureField("", text: $text)
                } else {
                    TextField("", text: $text)
                }
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(isFocused ? .mandamongPrimary : .mandamongSecondary, lineWidth: 1)
            }
            
            Text(title)
                .mandamongFont(isTitleFloating ? .caption : .secondary)
                .padding(.horizontal, isTitleFloating ? 4 : .zero)
                .background(.white)
                .padding(.leading, 12)
                .offset(y: isTitleFloating ? -30 : .zero)
                .onTapGesture { focused = focusType }
        }
        .animation(.spring(duration: 0.3), value: isTitleFloating)
        .animation(.spring(duration: 0.3), value: isFocused)
    }
}
