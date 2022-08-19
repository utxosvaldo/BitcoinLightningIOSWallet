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

let addInvoiceTask = Task {
    do {
        let lnInvoice = try await api.addInvoice(accountId: "2701d902-2489-444b-86dd-bbe400261e3b", amountMsat: 1000, memo: "")
        print("lnInvoice : \(String(describing: lnInvoice))")
    } catch let error {
        print("Error \(error)")
    }
}



