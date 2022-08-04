//
//  TestData.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 02/08/22.
//

import Foundation
import BitcoinDevKit

struct TestData {
    static let confirmedTx = Transaction.confirmed(details: TransactionDetails(fee: nil, received: 1000, sent: 10000, txid: "some-other-tx-id"), confirmation: BlockTime(height: 20087, timestamp: 1635863544))
    
    static let unconfirmedTx = Transaction.unconfirmed(details: TransactionDetails(fee: nil, received: 42069, sent: 1234, txid: "420-69-1234-0000"))
    
    static let transactions: [Transaction] = [unconfirmedTx, confirmedTx]
    
    static let bitcoinWallet = BitcoinWallet(balance: UInt64(42069000), lastUnusedAddress: "bc1qazusyn5ct7xah375k0z6l6w7qphg6vp7pau0p8", transactions: transactions)
}
