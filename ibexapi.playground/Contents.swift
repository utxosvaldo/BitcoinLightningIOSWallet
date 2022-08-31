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

let bolt11 = "lnbc12345670p1p3samkvpp5977wedmjd2jferhpas8m4msl62hffurmjrgsyy5lvwut6t3lpy5qdq623jhxapqd4jk6meqwashwcthvycqzpgxqzuysp5pl9evjf3jcmzey49pj0j7r2lqad7rgpeplwm4x04kskvm7zufgks9qyyssqaxyev39vevn75yxdyte4p460mmcxgs0esewfrqpfx5lfsdpkea0r525ehcwkal0r6ty32g9s2tnujs4kn6y2fq6vjmjfkkkmt50082spwc6r0q"

let InvoiceDetailsTask = Task {
    do {
        let details: LNInvoiceDetails = try await api.getInvoiceInfoWithBolt11(bolt11: bolt11)
        print("Invoice Details: \(String(describing: details))")
    } catch let error {
        print("Error \(error)")
    }
}

//let hash: String = await InvoiceDetailsTask.value





