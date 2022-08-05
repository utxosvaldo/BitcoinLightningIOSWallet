//
//  DoneButton.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 05/08/22.
//

import SwiftUI

struct DoneButton: View {
    var isAmountFocused: Bool
    let action: () -> Void
    
    var title: String {isAmountFocused ? "Done" : ""}
    
    var body: some View {
        Button(action: action){
            Text(title)
        }
    }
}

struct DoneButton_Previews: PreviewProvider {
    static var previews: some View {
        DoneButton(isAmountFocused: true, action: {})
    }
}
