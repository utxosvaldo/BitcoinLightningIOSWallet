//
//  LightningController.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 07/08/22.
//

import Foundation

class LightningController: ObservableObject {
    @Published var wallet: LightningWallet!
    private let ibexHubAPI = IbexHubAPI()
    

    init(id: String, name: String) {
        // Instanciate wallet and sync
        wallet = LightningWallet(id: id, name: name, balanceMsats: 0, transactions: [])
    }
    
    func sync() async -> Void {
        print("Syncing lightnign wallet ...")
        do {
            let ibexAccount = try await ibexHubAPI.getAccountDetails(accountId: wallet.id)
            let transactions = try await ibexHubAPI.getLatestTransactions(accountId: wallet.id)
            DispatchQueue.main.async {
                self.wallet.balanceMsats = ibexAccount.balanceMsats
                self.wallet.transactions = transactions
            }
        }
        catch let error {
            print("Error while syning lightning wallet: \(error)")
        }
    }
}
