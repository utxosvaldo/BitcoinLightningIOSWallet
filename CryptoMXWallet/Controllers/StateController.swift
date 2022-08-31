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
    @Published var bitcoinWalletExists:  Bool = false
    @Published var ibexSignedIn: Bool = false
    @Published var lightningWalletExists: Bool = false
    @Published var setUpDone: Bool
    @Published var bitcoinWallet: BitcoinWallet!
    @Published var lightningWallet: LightningWallet!
    @Published var latestLNInvoice: LNInvoice!
    private(set) var accessToken: String!
    private(set) var lightningController = LightningController()
    private(set) var bitcoinController = BitcoinController()
    private let storageController = StorageController()
    
    init() {
        setUpDone = storageController.doesSetUpDone()
        
        if setUpDone{
            loadExistingBitcoinWallet()
            loadExistingLightningWallet()
            
        }
         signIntoIbex()
    }
    
    func loadExistingBitcoinWallet(){
        let initialWalletData: RequiredInitialData = storageController.fetchInitialWalletData()
        print("Loading existing bitcoin wallet with \(initialWalletData)")
        
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
            
            storageController.saveBitcoinWallet(descriptor: initialWalletData.descriptor, changeDescriptor: initialWalletData.changeDescriptor)
            storageController.saveMnemonic(mnemonic: initialWalletData.mnemonic!)
            bitcoinWalletExists = true

        } catch let error {
            print("Error while creating bitcoin wallet: \(error)")
        }
    }
    
    func getMnemonic() -> String {
        return storageController.fetchMnemonic()
    }
    
    
    func importBitcoinWallet(seed: String){
        print("Importing wallet with mnemonic: \(seed)")
        do {
            let initialWalletData: RequiredInitialData = try bitcoinController.createWallet(seed: seed)
            bitcoinWallet = try bitcoinController.loadWallet(initialWalletData: initialWalletData)
            
            storageController.saveBitcoinWallet(descriptor: initialWalletData.descriptor, changeDescriptor: initialWalletData.changeDescriptor)
            storageController.saveMnemonic(mnemonic: initialWalletData.mnemonic!)
                        bitcoinWalletExists = true
        } catch let error {
            print("Error while importing bitcoin wallet: \(error)")
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
    
    func syncBitcoin() {
        Task {
            print("Syncing Bitcoin wallet...")
            do {
                let syncedBitcoinWallet = try bitcoinController.sync()
                DispatchQueue.main.async {
                    self.bitcoinWallet = syncedBitcoinWallet
                    print("Bitcoin wallet synced! Balance: \(self.bitcoinWallet.balance)")
                }
            }
            catch let error {
                print("Error while syncing bitcoin wallet: \(error)")
            }
        }
    }
    
    func syncLightning() {
        Task {
            print("Syncing Lightning wallet...")
            do {
                let syncedLightningWallet = try await lightningController.sync()
                DispatchQueue.main.async {
                    self.lightningWallet = syncedLightningWallet
                    self.storageController.saveLightningWallet(wallet: syncedLightningWallet)
                    print("Lightning wallet synced! Balance: \(self.lightningWallet.balanceSats)")
                }
            } catch let error {
                print("Error while syncing lightning wallet: \(error)")
            }
        }
    }
    
    func signIntoIbex() {
        Task {
            do{
                try await lightningController.initializeIbexHub()

                DispatchQueue.main.async {
                    self.ibexSignedIn = true
                }
            }
            catch let error{
                print("Error while signing into IbexHUB: \(error)")
            }
        }
    }
    
    func loadExistingLightningWallet() {
        let existingWallet: LightningWallet = storageController.fetchLightningWallet()
        print("Loading existing lightning wallet with \(existingWallet)")
        
//        Task {
//            do{
//                let loadedLightningWallet = try await lightningController.initializeWallet(id: initialWalletData.id)
//
//                DispatchQueue.main.async {
        self.lightningWallet = existingWallet
        self.lightningWalletExists = true
//                }
//            }
//            catch let error{
//                print("Error while loading lightning wallet: \(error)")
//            }
//        }
    }

    
    func createLightningWallet(name: String) {
        Task {
            do{
                let newLightningWallet = try await lightningController.createWallet(name: name)
                
                DispatchQueue.main.async {
                    self.lightningWallet = newLightningWallet
                    self.storageController.saveLightningWallet(wallet: newLightningWallet)
                    self.lightningWalletExists = true
                    self.storageController.saveSetUpDone()
                }
            }
            catch let error{
                print("Error while creating lightning wallet: \(error)")
            }
        }
    }
    
    func importLightningWallet(id: String) {
        Task {
            do{
                let importedLightningWallet = try await lightningController.loadWallet(id: id)
                
                DispatchQueue.main.async {
                    self.lightningWallet = importedLightningWallet
                    self.lightningWalletExists = true
                    self.storageController.saveLightningWallet(wallet: importedLightningWallet)
                }
            }
            catch let error{
                print("Error while creating lightning wallet: \(error)")
            }
        }
    }
    
    func clearLatestInvoice() {
        latestLNInvoice = nil
    }
    
    func createInvoice(amount: String, memo: String){
        Task {
            do{
                let lnInvoice = try await self.lightningController.addInvoice(amountMsat: amount.toUInt64, memo: memo)
                
                DispatchQueue.main.async {
                    self.latestLNInvoice = lnInvoice
                }
            }
            catch let error{
                print("Error while creating lightning invoice: \(error)")
            }
        }
    }
}
