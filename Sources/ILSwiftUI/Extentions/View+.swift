//
//  View+.swift
//  ILSwiftUI
//
//  Created by CucNV on 9/4/25.
//

import SwiftUI

extension View{
    public func overlayRoundedRect(radius:CGFloat = 8,
                                   lineWidth:CGFloat = 1,
                                   color:Color = .gray) -> some View {
        return self
            .overlay(RoundedRectangle(cornerRadius: radius)
                .stroke(color, lineWidth: lineWidth))

        
    }

}
