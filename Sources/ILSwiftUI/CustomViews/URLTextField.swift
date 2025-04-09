//
//  UrlTextField.swift
//  ILINXCapture
//
//  Created by CucNV on 20/2/25.
//

import SwiftUI

public struct URLTextField: View {

    @Binding var text: String

    @Binding var displayText:String

    @State var iconType: String?

    var titleKey: String

    @FocusState var isTyping: Bool

    let httpsPrefix: String = "https://"
    let httpPrefix: String = "http://"
    let iconSecure: String = "lock.circle"
    let iconNotSecure: String = "lock.open"

    public init(text:Binding<String>,
                displayText:Binding<String>,
                titleKey: String) {
        _text = text
        _displayText = displayText
        self.titleKey = titleKey
    }

    public var body: some View {
        HStack(spacing: 0){
            TextField(titleKey, text: $displayText)
            .focused($isTyping)
            .keyboardType(.URL)
            .textContentType(.URL)
            .submitLabel(.next)
            .padding([.vertical, .leading])
            if let iconType{
                Image(systemName: iconType)
                    .padding([.vertical, .trailing])
            }


        }
        .overlayRoundedRect()

        .onChange(of: isTyping) { _ ,  newValue in
            updateSecureUI()
        }
        .onChange(of: displayText) { _ ,  newValue in
            if let prefixUrl {
                text = prefixUrl + displayText
            }else{
                text = displayText
            }
        }
        .task {
            displayText = text
            updateSecureUI()
        }
    }

    var prefixUrl: String? {
        return prefixFromIcon(iconType)
    }

    func iconForCurrentText(_ value:String) -> String?{
        if value.starts(with: httpsPrefix){
            return iconSecure
        } else if value.starts(with: httpPrefix){
            return iconNotSecure
        }
        return nil
    }

    func prefixFromIcon(_ value:String?) -> String?{
        guard let value else { return nil}
        if value == iconSecure {
            return httpsPrefix
        } else if iconType == iconNotSecure {
            return httpPrefix
        }
        return nil
    }

    func updateSecureUI() {
        if isTyping {
            //Hide secure icon when typing
            if let prefixUrl,
               !displayText.hasPrefix(prefixUrl){
                displayText = prefixUrl + displayText
                iconType = nil
            }

        }else{
            //show or auto add secure icon
            if let iconType = iconForCurrentText(displayText){
                self.iconType = iconType
                if let prefixUrl{
                    displayText = text.replacingOccurrences(of: prefixUrl, with: "")
                }
            }
            else {
                //set default secure icon for empty
                if iconForCurrentText(text) == nil {
                    text = httpsPrefix + text
                    iconType = iconSecure
                }
            }
        }

    }

}

#Preview {
    URLTextField(
        text: .constant("https://www.google.com"),
        displayText: .constant("https://www.google.com"),
        titleKey: "https://")
    .padding()

}
