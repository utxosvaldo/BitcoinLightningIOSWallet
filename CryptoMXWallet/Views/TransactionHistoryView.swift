//
//  TransactionHistoryView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 16/07/22.
//

import SwiftUI

struct TransactionHistoryView: View {
    @EnvironmentObject var wallet: Wallet
    
    var body: some View {
        ScrollView {
            if wallet.transactions.isEmpty {
                Text("No transactions yet.").padding()
            } else {
                ForEach(wallet.transactions, id: \.self){ transaction in
                    SingleTxView(transaction: transaction)
                }
            }
        }
    }
}

struct TransactionHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionHistoryView()
            .environmentObject(Wallet())
    }
}
