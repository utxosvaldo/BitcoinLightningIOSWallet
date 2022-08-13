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
    private let ibexHubAPI = IbexHubAPI()
    
    private func initializeWallet(id: String) async throws -> LightningWallet{
        let details: IbexAccountDetails = try await ibexHubAPI.getAccountDetails(accountId: id)
        let transactions: [LNTransaction] = try await ibexHubAPI.getLatestTransactions(accountId: id)

        return LightningWallet(id: details.id, name: details.name, balanceMsats: details.balanceMsat, transactions: transactions)
    }
    
    func createWallet(name: String) async throws -> LightningWallet {
        let ibexAccount: IbexAccount = try await ibexHubAPI.createIbexAccount(name: name)
        print("Created ibex account: \(String(describing: ibexAccount))")
        
        accountId = ibexAccount.id
        return LightningWallet(id: ibexAccount.id, name: ibexAccount.name, balanceMsats: 0, transactions: [])
    }
    
    func loadWallet(id: String) async throws -> LightningWallet {
        self.accountId = id
        let lightningWallet: LightningWallet = try await initializeWallet(id: id)
        print("Finished loading lightning wallet: \(String(describing: lightningWallet))")
        
        return lightningWallet
    }
    
    func sync() async throws -> LightningWallet {
        print("Syncing lightning wallet with id \(String(describing: accountId))...")
        let details: IbexAccountDetails = try await ibexHubAPI.getAccountDetails(accountId: accountId)
        let transactions = try await ibexHubAPI.getLatestTransactions(accountId: accountId)
        
        return LightningWallet(id: details.id, name: details.name, balanceMsats: details.balanceMsat, transactions: transactions)
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
