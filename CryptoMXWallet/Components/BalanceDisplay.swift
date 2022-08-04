//
//  BalanceDisplay.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 01/06/22.
//

import SwiftUI

struct BalanceDisplay: View {
    let balanceText: String
    
    var body: some View {
        Text("₿ \(balanceText)")
            .font(.system(size: 32, design: .monospaced))
            .fontWeight(.semibold)
            .foregroundColor(Color("AccentColor"))
            .padding(10)
            .frame(maxWidth: .infinity)
    }
}

struct BalanceDisplay_Previews: PreviewProvider {
    static var previews: some View {
        BalanceDisplay(balanceText: TestData.bitcoinWallet.balanceText)
    }
}
