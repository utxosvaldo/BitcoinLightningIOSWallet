//
//  LightningController.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 07/08/22.
//

import Foundation
import BitcoinDevKit

class LightningController: ObservableObject {
    private(set) var accountId: String!
    private(set) var ibexHubAPI = IbexHubAPI()
    
    func initializeIbexHub() async throws {
        print("Getting access token........")
        let signInTask = Task {() -> String in
            let auth: Auth = try await ibexHubAPI.getAccessToken()
            return auth.accessToken
        }
        let accessToken = try await signInTask.value
        print("Got access Token: \(accessToken)")
        ibexHubAPI.updateAccessToken(accessToken: accessToken)
    }
    
    func initializeWallet(id: String) async throws -> LightningWallet{
        let detailsTask = Task {() -> IbexAccountDetails? in
            let details = try await ibexHubAPI.getAccountDetails(accountId: id)
            return details
        }
        
        let transactionsTask = Task {() -> [LNTransaction]? in
            let txs = try await ibexHubAPI.getLatestTransactions(accountId: id)
            return txs
        }
        
        let details = try await detailsTask.value!
        let transactions = try await transactionsTask.value!
        self.accountId = details.id
        
        return LightningWallet(id: details.id, name: details.name, balanceMsats: details.balanceMsat, transactions: transactions)
    }
    
    func createWallet(name: String) async throws -> LightningWallet {
        let accountTask = Task {() -> IbexAccount? in
//            try await ibexHubAPI.getAccessToken()
            let ibexAccount = try await ibexHubAPI.createIbexAccount(name: name)
            return ibexAccount
        }
        
        let account = try await accountTask.value!
        self.accountId = account.id
        
        return LightningWallet(id: account.id, name: account.name, balanceMsats: 0, transactions: [])
    }
    
    func loadWallet(id: String) async throws -> LightningWallet{
        let lightningWallet: LightningWallet = try await initializeWallet(id: id)
        print("Finished loading lightning wallet: \(String(describing: lightningWallet))")
        
        return lightningWallet
    }
    
    func sync() async throws -> LightningWallet {
        print("Syncing lightning wallet with id \(String(describing: accountId))...")
        let details: IbexAccountDetails = try await ibexHubAPI.getAccountDetails(accountId: accountId)
        let transactions = try await ibexHubAPI.getLatestTransactions(accountId: accountId)
        
        let syncedWallet = LightningWallet(id: details.id, name: details.name, balanceMsats: details.balanceMsat, transactions: transactions)
        
        return syncedWallet
    }
    
    func addInvoice(amountMsat: UInt64, memo: String) async throws -> LNInvoice {
        let lnInvoice = try await ibexHubAPI.addInvoice(accountId: accountId, amountMsat: amountMsat, memo: memo)
        
        return lnInvoice
    }
    
    func payInvoice(bolt11: String, amountMsat:UInt64) async throws -> LNInvoiceReceipt {
        let lnInvoiceReceipt = try await ibexHubAPI.payInvoice(accountId: accountId, bolt11: bolt11, amountMsat: amountMsat)
        
        return lnInvoiceReceipt
    }
    
    func decodeBolt11(bolt11: String) async throws -> LNInvoiceDetails {
        let lnInvoiceDetails = try await ibexHubAPI.getInvoiceInfoWithBolt11(bolt11: bolt11)
        
        return lnInvoiceDetails
    }
}
