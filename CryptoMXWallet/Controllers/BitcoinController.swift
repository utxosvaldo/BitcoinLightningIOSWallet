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

    init(descriptor: String, changeDescriptor: String, network: BitcoinDevKit.Network) {
        self.path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

        let electrum = ElectrumConfig(url: "192.168.1.70:50001", socks5: nil, retry: 5, timeout: nil, stopGap: 10)
        let database = DatabaseConfig.sled(config: SledDbConfiguration(path: "\(self.path)/bitcoinWallet", treeName: "bitcoinWallet"))
        do {
            blockchain = try BitcoinDevKit.Blockchain(config: BlockchainConfig.electrum(config: electrum))
        }
        catch let error {
            print("Initialize blockchain error: \(error)")
        }
        
        do {
            bdkWallet = try BitcoinDevKit.Wallet(descriptor: descriptor, changeDescriptor: changeDescriptor, network: network, databaseConfig: database)
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
        
//        sync()
    }
    
    func sync() async -> Void {
        print("Syncing Bitoin wallet...")
        do {
            try bdkWallet.sync(blockchain: blockchain, progress: nil)
            let balance = try bdkWallet.getBalance()
            let transactions = try bdkWallet.getTransactions()
            DispatchQueue.main.async {
                self.wallet.balance = balance
                self.wallet.lastUnusedAddress = self.bdkWallet.getLastUnusedAddress()
                self.wallet.transactions = transactions
            }
            
            print("Wallet Balance: \(wallet.balance)")
//            print("Wallet BalanceText: \(wallet.balanceText))
            print("Wallet synced!")
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
