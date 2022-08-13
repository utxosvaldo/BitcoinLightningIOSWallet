//
//  StateController.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 02/08/22.
//

import Foundation
import BitcoinDevKit
import UIKit
import CloudKit

class StateController: ObservableObject {
    @Published var bitcoinWalletExist:  Bool
    @Published var lightningWalletExists: Bool
    @Published var bitcoinWallet: BitcoinWallet!
    @Published var lightningWallet: LightningWallet!
    private(set) var lightningController: LightningController!
    private(set) var bitcoinController = BitcoinController()
    private let ibexHubAPI = IbexHubAPI()
    private let storageController = StorageController()
    
    init() {
        self.bitcoinWalletExist = storageController.doesBitcoinWalletExist()
        self.lightningWalletExists = storageController.doesLightningWalletExist()
        if self.bitcoinWalletExist {
            loadExistingBitcoinWallet()
        }
        if self.lightningWalletExists {
            loadExistingLightningWallet()
        }
    }
    
    func loadExistingBitcoinWallet(){
        let initialWalletData: RequiredInitialData = storageController.fetchInitialWalletData()
        print("Loading existing wallet, descriptor is \(initialWalletData.descriptor)")
        print("Loading existing wallet, change descriptor is \(initialWalletData.changeDescriptor)")
        
        do {
            bitcoinWallet = try bitcoinController.loadWallet(initialWalletData: initialWalletData)
        } catch let error {
            print("Error while loading existing bitcoin wallet: \(error)")
        }
    }
    
    func createBitcoinWallet(){
        do {
            let initialWalletData: RequiredInitialData = try bitcoinController.createWallet()
            bitcoinWallet = try bitcoinController.loadWallet(initialWalletData: initialWalletData)
            
            bitcoinWalletExist = true
            storageController.saveBitcoinWallet(descriptor: initialWalletData.descriptor, changeDescriptor: initialWalletData.changeDescriptor)
            storageController.saveMnemonic(mnemonic: initialWalletData.mnemonic!)
            
        } catch let error {
            print("Error while creating bitcoin wallet: \(error)")
        }
    }
    
    func importBitcoinWallet(seed: String){
        print("Importing wallet with mnemonic: \(seed)")
        do {
            let initialWalletData: RequiredInitialData = try bitcoinController.createWallet(seed: seed)
            bitcoinWallet = try bitcoinController.loadWallet(initialWalletData: initialWalletData)
            
            bitcoinWalletExist = true
            storageController.saveBitcoinWallet(descriptor: initialWalletData.descriptor, changeDescriptor: initialWalletData.changeDescriptor)
            storageController.saveMnemonic(mnemonic: initialWalletData.mnemonic!)
            
        } catch let error {
            print("Error while importing bitcoin wallet: \(error)")
        }
    }
    
    func sync() {
        Task {
            print("Syncing Bitcoin wallet...")
            do {
                let syncedBitcoinWallet = try await bitcoinController.sync()
                DispatchQueue.main.async {
                    self.bitcoinWallet = syncedBitcoinWallet
                }
                print("Bitcoin wallet synced! Balance: \(self.bitcoinWallet.balance)")
            }
            catch let error {
                print("Error while syncing bitcoin wallet: \(error)")
            }
        }
    }
    
    func broadcastTx(recipient: String, amount: UInt64) {
        do {
            let txid:String = try bitcoinController.broadcastTx(recipient: recipient, amount: amount)
            print("Sent: \(amount) Sats")
            print("To: \(recipient)")
            print("TxId: \(txid)")
        }
        catch let error {
            print("Error while broadcasting transaction: \(error)")
        }
    }
    
    private func loadExistingLightningWallet() {
        let initialWalletData: RequiredInitialLightningData = storageController.fetchInitialLightningWalletData()
        print("Loading existing lightning wallet with \(initialWalletData)")
        lightningController = LightningController(id: initialWalletData.id, name: initialWalletData.name)
    }
    
    func createLightningWallet(name: String) async {
        do{
            let ibexAccount = try await ibexHubAPI.createIbexAccount(name: name)
            print("Created ibex account: \(String(describing: ibexAccount))")
            
            lightningController = LightningController(id: ibexAccount.id, name: ibexAccount.name)
            DispatchQueue.main.async {
                self.lightningWalletExists = true
                
            }
        }
        catch let error{
            print("Error while creating ibex account: \(error)")
        }
        
    }
    

    
    func importLightningWallet(id: String, name: String) {
        lightningController = LightningController(id: id, name: name)
        lightningWalletExists = true
        storageController.saveLightningWallet(id: id, name: name)
    }
}
