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
    
    static let lightningWallet = LightningWallet(id: "ab124d8a-f9b8-401e-87f0-f8bbc8188156", name: "My Lightning Wallet", balanceMsats: 123456000, transactions: [])
    
    static let lnInvoice = LNInvoice(bolt11: "lnbc10n1p30lg68pp5rqv7u6hds08gc54k5x5eze6usm8c7pz3nz952gvfxac7frwyvmaqdqqcqzpgxqzuysp5gc4pur9wgu5de5738n4fc58kj77m0a4xgl8tmzm5nwjvjjln8dhs9qyyssqjr0zt7eygxsq8z5gvae745p0qduzgk4eqlem3v92t4au9tsugz7nxhgxl5cv8g9mf2kd2k76yvv4dy2r0cyetkv8d4vyf5p69sqw6ngqep3u3g", hash: "1819ee6aed83ce8c52b6a1a991675c86cf8f0451988b4521893771e48dc466fa", expirationUtc: 1660921547)
}
