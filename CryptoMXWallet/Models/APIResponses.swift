//
//  APIResponses.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 12/08/22.
//

import Foundation

struct IbexAccount: Codable {
    var id: String
    var name: String
}

struct IbexAccountDetails: Codable {
    var id: String
    var name: String
    var balanceMsat: UInt64
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

struct LNInvoiceReceipt: Codable {
    var settleTimeUTC: String
    var hash: String
    var amountMsat: UInt64
    var feesMsat: UInt64
}

struct LNInvoiceDetails: Codable {
    var id: UInt64
    var hash: String
    var bolt11: String
    var preImage: String?
    var memo: String
    var creationDateUtc: String
    var expiryDateUtc: String
    var settleDateUtc: String?
    var amountMsat: UInt64
    var receiveMsat: UInt64
    var stateId: Int
    var state: LNInvoiceState
    
}

struct LNInvoiceState: Codable {
    var id: UInt
    var name: String
    var description: String?
}

