//
//  BasicButton.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 23/06/22.
//

import SwiftUI

struct BasicButton: View {
    var action: () -> Void
    var text: String
    var color = "AccentColor"
    
    var body: some View {
        Button(action: action) {
                    Text(text)
//                        .font(.system(size: 14, design: .monospaced))
                        .fontWeight(.bold)
//                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .foregroundColor(.white)
//                        .padding(10)
                        .padding()
                        .padding(.horizontal)
                        .background(Color(color))
                        .cornerRadius(30.0)
                        .shadow(color: Color("Shadow"), radius: 10)
                }
    }
}

struct BasicButton_Previews: PreviewProvider {
    static var previews: some View {
        BasicButton(action: {}, text: "Test")
    }
}
