//
//  StateController.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 02/08/22.
//

import Foundation
import BitcoinDevKit
import UIKit

class StateController: ObservableObject {
    @Published var bitcoinWalletExist:  Bool
    @Published var bitcoinWallet:  BitcoinWallet!
    private(set) var bdkWallet: BitcoinDevKit.Wallet!
    private(set) var blockchain: BitcoinDevKit.Blockchain!
    private(set) var path: String
    private let storageController = StorageController()
    
    init() {
        self.path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        self.bitcoinWalletExist = storageController.doesBitcoinWalletExist()
        if self.bitcoinWalletExist {
            loadExistingBitcoinWallet()
        }
    }
    
    private func initializeBitcoinWallet(descriptor: String, changeDescriptor: String) {
        let electrum = ElectrumConfig(url: "ssl://electrum.blockstream.info:60002", socks5: nil, retry: 5, timeout: nil, stopGap: 10)
        let database = DatabaseConfig.sled(config: SledDbConfiguration(path: "\(path)/bitcoinWallet", treeName: "bitcoinWallet"))
        do {
            blockchain = try BitcoinDevKit.Blockchain(config: BlockchainConfig.electrum(config: electrum))
        } catch let error {
            print("Initialize blockchain error: \(error)")
        }
        
        do {
            bdkWallet = try BitcoinDevKit.Wallet(descriptor: descriptor, changeDescriptor: changeDescriptor, network: Network.testnet, databaseConfig: database)
            let balance = try bdkWallet.getBalance()
            let lastUnusedAddress = bdkWallet.getLastUnusedAddress()
            let transactions = try bdkWallet.getTransactions()
            bitcoinWallet = BitcoinWallet(
                balance: balance,
                lastUnusedAddress: lastUnusedAddress,
                transactions: transactions
            )
        } catch let error {
            print("Initialize wallet error: \(error)")
        }
        
        sync()
    }
    
    
    private func loadExistingBitcoinWallet(){
        let initialWalletData: RequiredInitialData = storageController.fetchInitialWalletData()
        print("Loading existing wallet, descriptor is \(initialWalletData.descriptor)")
        print("Loading existing wallet, change descriptor is \(initialWalletData.changeDescriptor)")
        
        initializeBitcoinWallet(descriptor: initialWalletData.descriptor, changeDescriptor: initialWalletData.changeDescriptor)
    }
    
    func sync() -> Void {
        print("Syncing wallet...")
        do {
            try bdkWallet.sync(blockchain: blockchain, progress: nil)
            bitcoinWallet.balance = try bdkWallet.getBalance()
            bitcoinWallet.lastUnusedAddress = bdkWallet.getLastUnusedAddress()
            bitcoinWallet.transactions = try bdkWallet.getTransactions()
        } catch let error {
            print("Syncing error: \(error)")
        }
        
    }
    
    func createWalletFromScratch(){
        do {
            let keys: ExtendedKeyInfo = try generateExtendedKey(network: Network.testnet, wordCount: WordCount.words12, password: nil)
            let descriptor: String = createDescriptor(keys: keys)
            let changeDescriptor: String = createChangeDescriptor(keys: keys)
            
            print("Creating wallet, descriptor is \(descriptor)")
            print("Creating wallet, change descriptor is \(changeDescriptor)")
            print("Creating wallet, mnemonic is: \(keys.mnemonic)")
            
            initializeBitcoinWallet(descriptor: descriptor, changeDescriptor: changeDescriptor)
            
            bitcoinWalletExist = true
            storageController.saveBitcoinWallet(path: path, descriptor: descriptor, changeDescriptor: changeDescriptor)
            storageController.saveMnemonic(mnemonic: keys.mnemonic)
            
        } catch let error {
            print(error)
        }
    }
    
    func importWallet(seed: String){
        print("Importing wallet with mnemonic: \(seed)")
        do {
            let keys: ExtendedKeyInfo = try restoreExtendedKey(network: Network.testnet, mnemonic: seed, password: nil)
            let descriptor: String = createDescriptor(keys: keys)
            let changeDescriptor: String = createChangeDescriptor(keys: keys)
            
            initializeBitcoinWallet(descriptor: descriptor, changeDescriptor: changeDescriptor)
            
            bitcoinWalletExist = true
            storageController.saveBitcoinWallet(path: path, descriptor: descriptor, changeDescriptor: changeDescriptor)
            storageController.saveMnemonic(mnemonic: keys.mnemonic)
            
        } catch let error {
            print("Import wallet error: \(error)")
        }
    }
    
    private func createDescriptor(keys: ExtendedKeyInfo) -> String {
        let descriptor: String = "wpkh(\(keys.xprv)/84'/1'/0'/0/*)"
        print("descriptor: \(descriptor)")
        return descriptor
    }
    
    private func createChangeDescriptor(keys: ExtendedKeyInfo) -> String {
        let changeDescriptor: String = "wpkh(\(keys.xprv)/84'/1'/0'/1/*)"
        print("change descriptor: \(changeDescriptor)")
        return changeDescriptor
    }
    
    func broadcastTx(recipient: String, amount: UInt64) {
        do{
            let txBuilder = TxBuilder().addRecipient(address: recipient, amount: amount)
            
            let psbt = try txBuilder.finish(wallet: bdkWallet)
            try bdkWallet.sign(psbt: psbt)
            try blockchain.broadcast(psbt: psbt)
            let txid = psbt.txid()
            print("Transaction Id: \(txid)")
        } catch let error {
            print(error)
        }
    }
    
}
