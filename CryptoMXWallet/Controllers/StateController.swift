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
    @Published var lightningWalletExists: Bool
    @Published var lightingWallet: LightningWallet!
    @Published var bitcoinWallet:  BitcoinWallet!
    @Published var ibexAccount: IbexAccount!
    private(set) var bitcoinController: BitcoinController!
    private let ibexHubAPI = IbexHubAPI()
    private let storageController = StorageController()
    
    init() {
        self.bitcoinWalletExist = storageController.doesBitcoinWalletExist()
        self.lightningWalletExists = storageController.doesLightningWalletExist()
        if self.bitcoinWalletExist {
            loadExistingBitcoinWallet()
            if self.lightningWalletExists {
                loadExistingLightningWallet()
            }
        }
    }
    
    private func loadExistingBitcoinWallet(){
        let initialWalletData: RequiredInitialData = storageController.fetchInitialWalletData()
        print("Loading existing wallet, descriptor is \(initialWalletData.descriptor)")
        print("Loading existing wallet, change descriptor is \(initialWalletData.changeDescriptor)")
        
        bitcoinController = BitcoinController(descriptor: initialWalletData.descriptor, changeDescriptor: initialWalletData.changeDescriptor)
    }
    
    private func loadExistingLightningWallet() {
        
    }
    
    func createLightningWallet(name: String) async{
        do{
            ibexAccount = try await ibexHubAPI.createIbexAccount(name: name)
            print("Created ibex account: \(String(describing: ibexAccount))")
        }
        catch let error{
            print("Error while creating ibex account: \(error)")
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
            
            bitcoinController = BitcoinController(descriptor: descriptor, changeDescriptor: changeDescriptor)
            
            bitcoinWalletExist = true
            storageController.saveBitcoinWallet(path: bitcoinController.path, descriptor: descriptor, changeDescriptor: changeDescriptor)
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
            
            bitcoinController = BitcoinController(descriptor: descriptor, changeDescriptor: changeDescriptor)
            
            bitcoinWalletExist = true
            storageController.saveBitcoinWallet(path: bitcoinController.path, descriptor: descriptor, changeDescriptor: changeDescriptor)
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
    
    func createIbexAccount() {
        
    }
}
