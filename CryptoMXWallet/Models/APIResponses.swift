//
//  APIResponses.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 12/08/22.
//

import Foundation

struct Auth: Codable{
    var accessToken: String
}

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
//    var amountMsat: Int64
    
    var bolt11: String
//    var feeMsat: UInt64
//    var hash: String
//    var memo: String?
//    var settleDateUtc: String
}

struct LNInvoice: Codable {
    var bolt11: String
    var hash: String
    var expirationUtc: UInt64
}

struct LNInvoiceReceipt: Codable {
//    var settleDateUtc: UInt64
    var hash: String
    var amountMsat: UInt64
    var feesMsat: UInt64
}

struct DecodedLNInvoice: Codable {
    var amountMsat: UInt64
    var description: String
}

struct LNInvoiceDetails: Codable {
    var hash: String
    var bolt11: String
    var preImage: String
    var memo: String
    var creationDateUtc: String
    var expiryDateUtc: String
//    var settleDateUtc: String?
    var amountMsat: UInt64
    var receiveMsat: UInt64
    var stateId: Int
//    var state: LNInvoiceState
    
}

struct LNInvoiceState: Codable {
    var id: UInt
    var name: String
    var description: String?
}

