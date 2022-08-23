//
//  IbexHub.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 10/08/22.
//

import Foundation
import CoreMedia
import CoreMIDI
import UIKit


let api = IbexHubAPI()
let lnController = LightningController()

//let transactionTask = Task {
//    do {
//        let transactions = try await api.getLatestTransactions(accountId: "2701d902-2489-444b-86dd-bbe400261e3b")
//        print("transactions: \(String(describing: transactions))")
//    } catch let error {
//        print("Error \(error)")
//    }
//}

//let addInvoiceTask = Task {
//    do {
//        let lnInvoice = try await api.addInvoice(accountId: "2701d902-2489-444b-86dd-bbe400261e3b", amountMsat: 1000, memo: "")
//        print("lnInvoice : \(String(describing: lnInvoice))")
//    } catch let error {
//        print("Error \(error)")
//    }
//}

let bolt11 = "lnbc10n1p30lg68pp5rqv7u6hds08gc54k5x5eze6usm8c7pz3nz952gvfxac7frwyvmaqdqqcqzpgxqzuysp5gc4pur9wgu5de5738n4fc58kj77m0a4xgl8tmzm5nwjvjjln8dhs9qyyssqjr0zt7eygxsq8z5gvae745p0qduzgk4eqlem3v92t4au9tsugz7nxhgxl5cv8g9mf2kd2k76yvv4dy2r0cyetkv8d4vyf5p69sqw6ngqep3u3g"

print("\(bolt11.prefix(10))...\(bolt11.suffix(10))")




