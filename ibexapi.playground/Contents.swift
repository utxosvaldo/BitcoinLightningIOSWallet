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


let getAccessTask = Task {
    do {
        let auth = try await api.getAccessToken()
        api.updateAccessToken(accessToken: auth.accessToken)
        print(auth.accessToken)
    } catch let error {
        print(error)
    }
}


//let lnController = LightningController()

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

let bolt11 = "lnbc100n1p3sl4stpp53jx5w8xu2rvwzlwgps40w6ea2pgaxl8ljzpdfzfuj06ezamd63xqdqqcqzpgxqzuysp57zv5f4rs295jexmv9q4rhfrugqc9rm9smezue2e07cy0ycr7d9dq9qyyssqldcxsvf435t8pgxr0stl0rpahgmm5u0tdnyxrlqew9t7rf69nahp2wd7lxgffgr6rwlnp7al8873yqz6h8mhvlx5zcj4kuagmevy9fsqzgmv3j"

let account_id = "4cedc213-4ced-45e6-a2b7-e73fe436f1d1"

//let InvoiceDetailsTask = Task {
//    do {
//        let details: LNInvoiceDetails = try await api.getInvoiceInfoWithBolt11(bolt11: bolt11)
//        print("Invoice Details: \(String(describing: details))")
//    } catch let error {
//        print("Error \(error)")
//    }
//}

//let decodeInvoiceTask = Task {
//    do {
//        let decodedInvoice = try await api.decodeInvoice(bolt11: bolt11)
//        print(decodedInvoice)
//    } catch let error {
//        print(error)
//    }
//}

let payInvoiceTask = Task {
    do {
        let lnReceipt: LNInvoiceReceipt = try await api.payInvoice(accountId: account_id, bolt11: bolt11, amountMsat: 10000)
        print(lnReceipt)
    } catch let error {
        print(error)
    }
}




