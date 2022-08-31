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

let bolt11 = "lnbc123450n1p3sln6vpp502zpyhflxzza8g6204dkqegek5fjvdjt92p0kkfrxkl4c0pgvu4qdqdg9ekgenpwdjxvcqzpgxqzuysp5e7mf3lsz27y74w0kmw9wpz5fqnr4dyvvjl0f7gfalrwkjkhyeupq9qyyssq92z48la8dslzvxlfpvznr5k5gwdxtkwz5xev6q9t2wtz3u59f20zxtpyph6q4wmepsz3rtv5h2p5k2fc35q6cse89tcc06r8q40rlagqsn678t"

//let account_id = "2701d902-2489-444b-86dd-bbe400261e3b"

//let InvoiceDetailsTask = Task {
//    do {
//        let details: LNInvoiceDetails = try await api.getInvoiceInfoWithBolt11(bolt11: bolt11)
//        print("Invoice Details: \(String(describing: details))")
//    } catch let error {
//        print("Error \(error)")
//    }
//}

let decodeInvoiceTask = Task {
    do {
        let decodedInvoice = try await api.decodeInvoice(bolt11: bolt11)
        print(decodedInvoice)
    } catch let error {
        print(error)
    }
}

//let payInvoiceTask = Task {
//    do {
//        let lnReceipt: LNInvoiceReceipt = try await api.payInvoice(accountId: account_id, bolt11: bolt11, amountMsat: 100000)
//        print(lnReceipt)
//    } catch let error {
//        print(error)
//    }
//}




