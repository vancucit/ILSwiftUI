//
//  Button+.swift
//  ILINXCapture
//
//  Created by CucNV on 8/2/25.
//

import SwiftUI


public struct ButtonConstants {
    public static let heightDefault:CGFloat = 54
    public static let foregroundColor:Color = .white
    public static let cornerRadius:CGFloat = 8
}

public struct PaddingButton: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
    }
}

extension View {

    public func makeButtonStyleBorder(height:CGFloat? = nil,
                                      foregroundColor:Color? = nil,
                                      backgroundColor:Color) -> some View {
        self
            .frame(maxWidth: .infinity)
            .frame(height:height ?? ButtonConstants.heightDefault)
//            .buttonStyle(PaddingButton())
            .foregroundColor(foregroundColor)
            .background(RoundedRectangle(cornerRadius: ButtonConstants.cornerRadius)
                .fill(backgroundColor))
    }

    public func makeButtonStyleOrange(height:CGFloat? = nil) -> some View {
        self.makeButtonStyleBorder( height: height,
            foregroundColor: ButtonConstants.foregroundColor,
            backgroundColor: .orange
        )
    }

}
