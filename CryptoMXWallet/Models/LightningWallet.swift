//
//  LNWallet.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 05/08/22.
//

import Foundation

struct LightningWallet {
    let ibexAccount: IbexAccount
    var balance: UInt64
    var transactions: [LNTransaction]
    var balanceText: String {
        String(format: "%.8f", Double(balance) / Double(100000000))
    }
}

struct LNTransaction: Codable, Identifiable {
    let id = UUID()
    var amountMsat: UInt64
    var bolt11: String
    var creationDateUtc: String
    var feeMsat: UInt64
    var hash: String
    var memo: String
    var settleDateUtc: String
}

struct IbexAccount: Codable {
    var id: String
    var userId: String
    var name: String
}
