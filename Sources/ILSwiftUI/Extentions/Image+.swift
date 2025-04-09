//
//  Image+.swift
//  ILSwiftUI
//
//  Created by CucNV on 9/4/25.
//

import SwiftUI

extension Image {
    public func resizedToFit(width: CGFloat, height: CGFloat? = nil,
                              contentMode: ContentMode = .fit) -> some View {
        return self
            .resizable()
            .aspectRatio(contentMode: contentMode)
            .frame(width: width, height: height ?? width)
    }

}
