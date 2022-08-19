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

let mainTask = Task {
    do {
        let transactions = try await api.getLatestTransactions(accountId: "2701d902-2489-444b-86dd-bbe400261e3b")
        print("transactions: \(String(describing: transactions))")
    } catch let error {
        print("Error \(error)")
    }
}



