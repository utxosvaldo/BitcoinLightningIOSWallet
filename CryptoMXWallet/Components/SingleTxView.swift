//
//  SingleTxView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 18/07/22.
//

import SwiftUI
import BitcoinDevKit

struct SingleTxView: View {
    let transaction: BitcoinDevKit.Transaction
    
//    let txDetails: BitcoinDevKit.TransactionDetails {
//        transaction.getDetails()
//    }
    
    var body: some View {
        VStack(alignment: .leading) {
            switch transaction {
            case .unconfirmed(let details):
                HStack {
                    Text("Received: \(String(details.received))")
                }
                HStack {
                    Text("Sent: \(String(details.sent))")
                }
                HStack {
                    Text("Fees: \(String(details.fee ?? 0))")
                }
                HStack {
                    Text("Txid:")
                    Text(details.txid)
                }
            case .confirmed(let details, let confirmation):
                HStack {
                    Text("Confirmed:")
                    Text((Date(timeIntervalSince1970: TimeInterval(confirmation.timestamp)).getFormattedDate(format: "yyyy-MM-dd HH:mm:ss")))
                }
                HStack {
                    Text("Block:")
                    Text(String(confirmation.height))
                }
                HStack {
                    Text("Received:")
                    Text(String(details.received))
                }
                HStack {
                    Text("Sent:")
                    Text(String(details.sent))
                }
                HStack {
                    Text("Fees:")
                    Text(String(details.fee ?? 0))
                }
                HStack {
                    Text("Txid:")
                    Text(details.txid)                }
            }
        }
        .foregroundColor(.white)
        .padding(10)
        .background(Color.blue).cornerRadius(5)
        .contextMenu{
            Button(action: {
                UIPasteboard.general.string = transaction.getDetails().txid}) {
                    Text("Copy Txid")
                }
        }.padding(.vertical, 10)
    }
}

struct SingleTxView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                SingleTxView(transaction: TestData.unconfirmedTx)
                SingleTxView(transaction: TestData.confirmedTx)
            }
        }
    }
}
