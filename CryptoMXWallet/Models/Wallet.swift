//
//  Wallet.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 01/06/22.
//

import Foundation
import SwiftUI
import BitcoinDevKit

class Wallet: ObservableObject {
    @Published private(set) var bdkWallet: BitcoinDevKit.Wallet!
    @Published private(set) var blockchain: BitcoinDevKit.Blockchain!
    @Published private(set) var path: String = ""
    private(set) var electrumURL: String = "ssl://electrum.blockstream.info:60002"
    @Published private(set) var balance: UInt64 = 0
    @Published private(set) var balanceText = "Sync wallet"
    @Published private(set) var latestAddress = "Generate new address"
    @Published private(set) var newAddress = "Generate new address"
    @Published private(set) var transactions: [BitcoinDevKit.Transaction] = []

    func setPath(pathToSave: String) {
        path = pathToSave
    }
    
    private func initialize(descriptor: String, changeDescriptor: String) {
        let electrum = ElectrumConfig(url: electrumURL, socks5: nil, retry: 5, timeout: nil, stopGap: 10)
        let database = DatabaseConfig.sled(config: SledDbConfiguration(path: "\(path)/bdkSled", treeName: "bskTree"))
        do {
            blockchain = try BitcoinDevKit.Blockchain(config: BlockchainConfig.electrum(config: electrum))
        } catch let error {
            print("Initialize blockchain error: \(error)")
        }
        
        do {
            bdkWallet = try BitcoinDevKit.Wallet(descriptor: descriptor, changeDescriptor: changeDescriptor, network: Network.testnet, databaseConfig: database)
        } catch let error {
            print("Initialize wallet error: \(error)")
        }
        
        // Sync
        sync()
    }
    
    func createWallet() {
        do {
            let keys: ExtendedKeyInfo = try generateExtendedKey(network: Network.testnet, wordCount: WordCount.words12, password: nil)
            let descriptor: String = createDescriptor(keys: keys)
            let changeDescriptor: String = createChangeDescriptor(keys: keys)
            
            initialize(descriptor: descriptor, changeDescriptor: changeDescriptor)
            
            // Repository.saveWallet(path, descriptor, change descriptor)
            // Respository.saveMnemonic(keys.mnemonic)
            
        } catch let error {
            print(error)
        }
    }
    
    private func createDescriptor(keys: ExtendedKeyInfo) -> String {
        var descriptor: String = "wpkh(\(keys.xprv)/84'/1'/0'/0/*)"
        print("descriptor: \(descriptor)")
        
        // for debugging
        descriptor = "wpkh(tprv8ZgxMBicQKsPdiCqH6nHDmXm6SL2TFkWS5T5jaZqa8hEPHWj9jjXL51z2jNWXsfiDzhNfBWKSmgS2ue9UnWEGX4Ej8SKE52PV1GDtmyyXVk/84'/1'/0'/0/*)"
        return descriptor
    }
    
    private func createChangeDescriptor(keys: ExtendedKeyInfo) -> String {
        var changeDescriptor: String = "wpkh(\(keys.xprv)/84'/1'/0'/1/*)"
        print("change descriptor: \(changeDescriptor)")
        
        // for debugging
        changeDescriptor = "wpkh(tprv8ZgxMBicQKsPdiCqH6nHDmXm6SL2TFkWS5T5jaZqa8hEPHWj9jjXL51z2jNWXsfiDzhNfBWKSmgS2ue9UnWEGX4Ej8SKE52PV1GDtmyyXVk/84'/1'/0'/1/*)"
        return changeDescriptor
    }
    
    func sync() {
        do {
            print("Syncing ...")
            try bdkWallet.sync(blockchain: blockchain!, progress: nil)
            balance = try bdkWallet.getBalance()
            balanceText = String(format: "%.8f", Double(balance) / Double(100000000))
            let wallet_transactions = try bdkWallet.getTransactions()
            transactions = wallet_transactions.sorted(by: {
            switch $0 {
            case .confirmed(_, let confirmation_a):
                switch $1 {
                case .confirmed(_, let confirmation_b): return confirmation_a.timestamp > confirmation_b.timestamp
                default: return false
                }
            default:
                switch $1 {
                case .unconfirmed(_): return true
                default: return false
                }
            } })
        } catch let error {
            print(error)
        }
    }
    
    func getNewAddress() {
        latestAddress = bdkWallet.getNewAddress()
        return
    }
    
    func getLastUnusedAddress() {
        latestAddress = bdkWallet.getLastUnusedAddress()
        return 
    }
    
    func broadcastTx(recipient: String, amount: UInt64) {
        do {
            let txBuilder = TxBuilder().addRecipient(address: recipient, amount: amount)
            let psbt = try txBuilder.finish(wallet: bdkWallet)
            try bdkWallet.sign(psbt: psbt)
            try blockchain.broadcast(psbt: psbt)
            let txid = psbt.txid()
            print(txid)
        } catch let error {
            print(error)
        }
    }
    
}
