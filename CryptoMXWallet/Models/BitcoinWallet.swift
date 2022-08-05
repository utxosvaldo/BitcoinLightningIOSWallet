//
//  Transaction.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 02/08/22.
//

import Foundation
import BitcoinDevKit
import UIKit

struct BitcoinWallet {
//    let name: String
    var balance: UInt64
    var lastUnusedAddress: String
    var transactions: [BitcoinDevKit.Transaction]
    
    var balanceText: String {
        String(format: "%.8f", Double(balance) / Double(100000000))
    }
    
    var lastUnusedAddressQR: UIImage {
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

extension BitcoinDevKit.Transaction {
    public func getDetails() -> TransactionDetails {
        switch self {
        case .unconfirmed(let details): return details
        case .confirmed(let details, _): return details
        }
    }
    
    public func getAmount() -> Int {
        let details = self.getDetails()
        let amount = Int(details.received) - Int(details.sent)
        return amount
    }
}

struct RequiredInitialData {
    let descriptor: String
    let changeDescriptor: String
}
