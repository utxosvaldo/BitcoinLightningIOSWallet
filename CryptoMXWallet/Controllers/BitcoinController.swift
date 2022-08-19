//
//  newBitcoinController.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 13/08/22.
//

import SwiftUI
import BitcoinDevKit

class BitcoinController: ObservableObject {
    private(set) var bdkWallet: BitcoinDevKit.Wallet!
    private(set) var blockchain: BitcoinDevKit.Blockchain!
    private(set) var path: String
    private let network: BitcoinDevKit.Network
    private let database: BitcoinDevKit.DatabaseConfig
    
//    private let electrum: ElectrumConfig = .init(url: "192.168.1.70:50001", socks5: nil, retry: 5, timeout: nil, stopGap: 10)
    
    
    private let electrum: ElectrumConfig = .init(url: "btc.lastingcoin.net:50002", socks5: nil, retry: 5, timeout: nil, stopGap: 10)

    init() {
        self.path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        self.network = .bitcoin
        self.database = .sled(config: SledDbConfiguration(path: "\(self.path)/bitcoinWallet", treeName: "bitcoinWallet"))
    }
    
    private func initializeWallet(descriptor: String, changeDescriptor: String) throws -> BitcoinWallet {
        self.blockchain = try BitcoinDevKit.Blockchain(config: BlockchainConfig.electrum(config: electrum))
        self.bdkWallet = try BitcoinDevKit.Wallet(descriptor: descriptor, changeDescriptor: changeDescriptor, network: network, databaseConfig: database)
        let balance = try bdkWallet.getBalance()
        let transactions = try bdkWallet.getTransactions()
        let lastUnusedAddress = bdkWallet.getLastUnusedAddress()
        
        return BitcoinWallet(balance: balance, lastUnusedAddress: lastUnusedAddress, transactions: transactions)
    }
    
    func loadWallet(initialWalletData: RequiredInitialData) throws -> BitcoinWallet {
        let bitcoinWallet: BitcoinWallet = try initializeWallet(descriptor: initialWalletData.descriptor, changeDescriptor: initialWalletData.changeDescriptor)
        
        return bitcoinWallet
    }
    
    func createWallet() throws -> RequiredInitialData {
        let keys: ExtendedKeyInfo = try generateExtendedKey(network: network, wordCount: WordCount.words12, password: nil)
        let descriptor: String = createDescriptor(keys: keys)
        let changeDescriptor: String = createChangeDescriptor(keys: keys)
        
        return RequiredInitialData(descriptor: descriptor, changeDescriptor: changeDescriptor, mnemonic: keys.mnemonic)
    }
    
    func createWallet(seed: String) throws -> RequiredInitialData {
        let keys: ExtendedKeyInfo = try restoreExtendedKey(network: network, mnemonic: seed, password: nil)
        let descriptor: String = createDescriptor(keys: keys)
        let changeDescriptor: String = createChangeDescriptor(keys: keys)
        
        return RequiredInitialData(descriptor: descriptor, changeDescriptor: changeDescriptor, mnemonic: keys.mnemonic)
    }
    
    func sync() throws -> BitcoinWallet {
        try bdkWallet.sync(blockchain: blockchain, progress: nil)
        let balance = try bdkWallet.getBalance()
        let transactions = try bdkWallet.getTransactions()
        let lastUnusedAddress = bdkWallet.getLastUnusedAddress()
        
        return BitcoinWallet(balance: balance, lastUnusedAddress: lastUnusedAddress, transactions: transactions)
    }
    
    func broadcastTx(recipient: String, amount: UInt64) throws -> String {
        let txBuilder = TxBuilder().addRecipient(address: recipient, amount: amount)
        
        let psbt = try txBuilder.finish(wallet: bdkWallet)
        try bdkWallet.sign(psbt: psbt)
        try blockchain.broadcast(psbt: psbt)
        
        return psbt.txid()
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
}
