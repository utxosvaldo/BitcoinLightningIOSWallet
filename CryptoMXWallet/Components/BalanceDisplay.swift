//
//  BalanceDisplay.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 01/06/22.
//

import SwiftUI

struct BalanceDisplay: View {
    var balance: String
    
    var body: some View {
        Text("₿ \(balance)")
            .font(.system(size: 32, design: .monospaced))
            .fontWeight(.semibold)
            .foregroundColor(Color("AccentColor"))
            .padding(10)
            .frame(maxWidth: .infinity)
//            .background(Color("Shadow"))
    }
}

struct BalanceDisplay_Previews: PreviewProvider {
    static var previews: some View {
        BalanceDisplay(balance: "0.00042069")
    }
}
