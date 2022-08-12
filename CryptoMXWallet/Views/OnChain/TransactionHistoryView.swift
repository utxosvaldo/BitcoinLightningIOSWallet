//
//  TransactionHistoryView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 16/07/22.
//

import SwiftUI
import BitcoinDevKit

struct TransactionHistoryView: View {
    @EnvironmentObject private var stateController: StateController
    
    var body: some View {
        Content(transactions: stateController.bitcoinController.wallet.transactions)
    }
}

extension TransactionHistoryView {
    struct Content: View {
        let transactions: [BitcoinDevKit.Transaction]
        
        var body: some View {
            VStack{
                HStack{
                    Text("Transaction History")
                        .lilacTitle()
                }
                ScrollView {
                    if transactions.isEmpty {
                        Text("No transactions yet.").padding()
                    } else {
                        ForEach(transactions, id: \.self){ transaction in
                            SingleTxView(transaction: transaction)
                        }
                    }
                }
            }
        }
    }
}

struct TransactionHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TransactionHistoryView.Content(transactions: TestData.transactions)
        }
    }
}
