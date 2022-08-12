//
//  LightningController.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 07/08/22.
//

import Foundation

class lightningController: ObservableObject {
    @Published var wallet: LightningWallet!
    

    init() {
        wallet = LightningWallet(ibexAccount: IbexAccount(id: "", userId: "", name: ""), balance: 12345, transactions: [])
    }
    
    func sync() -> Void {
        // call account/{id} endpoint to get latest account details from ibex
    }
}
