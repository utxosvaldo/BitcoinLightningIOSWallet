//
//  BasicTextStyle.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 22/06/22.
//

import SwiftUI

struct BasicTextStyle: ViewModifier {
    var big = false
    var white = false
    var bold = false
    func body(content: Content) -> some View {
        content
            .font(.system(size: big ? 32 : 14, design: .monospaced).weight(bold ? .bold : .regular))
            .foregroundColor(white ? Color.white : Color("Shadow"))
            .multilineTextAlignment(.trailing)
            
    }
}
extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

struct BasicTextStyle_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello").textStyle(BasicTextStyle())
    }
}
