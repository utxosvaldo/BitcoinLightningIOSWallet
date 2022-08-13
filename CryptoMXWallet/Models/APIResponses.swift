//
//  APIResponses.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 12/08/22.
//

import Foundation

struct IbexAccount: Codable {
    var id: String
    var userId: String
    var name: String
    var balanceMsats: UInt64?
    var bitcoinAddresses: [String]?
    var lightningAddresses: [String]?
}

struct LNTransaction: Codable {
    var amountMsat: UInt64
    var bolt11: String
    var creationDateUtc: String
    var feeMsat: UInt64
    var hash: String
    var memo: String
    var settleDateUtc: String
}

struct LNInvoice: Codable {
    var bolt11: String
    var hash: String
    var expirationUTC: UInt64
}
