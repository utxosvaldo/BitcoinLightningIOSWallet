//
//  BitcoinController.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 07/08/22.
//

import Foundation
import BitcoinDevKit


class BitcoinController: ObservableObject {
    @Published var wallet: BitcoinWallet!
    private(set) var path: String
    private(set) var bdkWallet: BitcoinDevKit.Wallet!
    private(set) var blockchain: BitcoinDevKit.Blockchain!

    init(descriptor: String, changeDescriptor: String) {
        self.path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

        let electrum = ElectrumConfig(url: "ssl://electrum.blockstream.info:60002", socks5: nil, retry: 5, timeout: nil, stopGap: 10)
        let database = DatabaseConfig.sled(config: SledDbConfiguration(path: "\(self.path)/bitcoinWallet", treeName: "bitcoinWallet"))
        do {
            blockchain = try BitcoinDevKit.Blockchain(config: BlockchainConfig.electrum(config: electrum))
        }
        catch let error {
            print("Initialize blockchain error: \(error)")
        }
        
        do {
            bdkWallet = try BitcoinDevKit.Wallet(descriptor: descriptor, changeDescriptor: changeDescriptor, network: Network.testnet, databaseConfig: database)
            let balance = try bdkWallet.getBalance()
            let lastUnusedAddress = bdkWallet.getLastUnusedAddress()
            let transactions = try bdkWallet.getTransactions()
            wallet = BitcoinWallet(
                balance: balance,
                lastUnusedAddress: lastUnusedAddress,
                transactions: transactions
            )
        }
        catch let error {
            print("Initialize wallet error: \(error)")
        }
        
        sync()
    }
    
    func sync() -> Void {
        print("Syncing wallet...")
        do {
            try bdkWallet.sync(blockchain: blockchain, progress: nil)
            wallet.balance = try bdkWallet.getBalance()
            wallet.lastUnusedAddress = bdkWallet.getLastUnusedAddress()
            wallet.transactions = try bdkWallet.getTransactions()
        } catch let error {
            print("Syncing error: \(error)")
        }
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
