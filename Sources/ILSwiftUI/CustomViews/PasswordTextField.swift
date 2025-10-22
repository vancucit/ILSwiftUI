//
//  HybridTextField.swift
//  ILINXCapture
//
//  Created by CucNV on 20/2/25.
//

import SwiftUI

public struct PasswordTextField: View {
    @Binding var text: String
    @State var isSecure: Bool = true
    var titleKey: String

    public init(text: Binding<String>, titleKey: String) {
        _text = text

        self.titleKey = titleKey
    }

    public var body: some View {
        HStack{
            Group{
                if isSecure{
                    SecureField(titleKey, text: $text)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                }else{
                    TextField(titleKey, text: $text)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                }
            }
            .padding([.vertical, .leading])

            .animation(.easeInOut(duration: 0.2), value: isSecure)
            //Add any common modifiers here so they dont have to be repeated for each Field
            Button(action: {
                isSecure.toggle()
            }, label: {
                Image(systemName: !isSecure ? "eye.slash" : "eye" )
                    .renderingMode(.template)
                    .foregroundColor(Color(UIColor.label))
            })
            .padding([.vertical, .trailing])
        }
        .overlayRoundedRect(color: .gray)
//        .overlayRoundedRect(color: text.isEmpty ? .red : .gray)

    }
}
#Preview {
    PasswordTextField(text: .constant("123"), titleKey: "Password")
        .padding()
}
