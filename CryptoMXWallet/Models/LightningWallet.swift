//
//  LNWallet.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 05/08/22.
//

import Foundation

struct LNWallet {
    let id: String
    var balance: UInt64
    var transactions: [LNTransaction]
    var balanceText: String {
        String(format: "%.8f", Double(balance) / Double(100000000))
    }
}

struct LNTransaction {
    let amount: UInt64
}
