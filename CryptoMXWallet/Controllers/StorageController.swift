//
//  StorageController.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 02/08/22.
//

import Foundation

class StorageController {
    private let userDefaults: UserDefaults = UserDefaults.standard
    
    func doesSetUpDone() -> Bool {
        return self.userDefaults.value(forKey: "setUpDone") as? Bool ?? false
    }
    
    func doesBitcoinWalletExist() -> Bool {
        return self.userDefaults.value(forKey: "bitcoinWalletInitialized") as? Bool ?? false
    }
    
    func doesLightningWalletExist() -> Bool {
        return self.userDefaults.value(forKey: "lightningWalletInitialized") as? Bool ?? false
    }
    
    func saveSetUpDone() {
        self.userDefaults.set(true, forKey: "setUpDone")
    }
    
    func saveLightningWallet(wallet: LightningWallet) {
        self.userDefaults.set(true, forKey: "lightningWalletInitialized")
        self.userDefaults.set(wallet.id, forKey: "lightningId")
        self.userDefaults.set(wallet.name, forKey: "lightningName")
        self.userDefaults.set(wallet.balanceMsats, forKey: "lightningBalance")
        self.userDefaults.set(wallet.transactions, forKey: "lightningTransactions")
    }
    
    func saveBitcoinWallet(descriptor: String, changeDescriptor: String){
        self.userDefaults.set(true, forKey: "bitcoinWalletInitialized")
        self.userDefaults.set(descriptor, forKey: "descriptor")
        self.userDefaults.set(changeDescriptor, forKey: "changeDescriptor")
    }
    
    func saveMnemonic(mnemonic: String) {
        print("Recovery phrase is: \(mnemonic)")
        self.userDefaults.set(mnemonic, forKey: "mnemonic")
    }
    
    func fetchMnemonic() -> String {
        let mnemonic = self.userDefaults.value(forKey: "mnemonic") as? String ?? ""
        return mnemonic
    }
    
    func fetchInitialWalletData() -> RequiredInitialData {
        let descriptor: String = self.userDefaults.value(forKey: "descriptor") as? String ?? ""
        let changeDescriptor: String = self.userDefaults.value(forKey: "changeDescriptor") as? String ?? ""
        
        return RequiredInitialData(descriptor: descriptor, changeDescriptor: changeDescriptor, mnemonic: nil)
    }
    
    func fetchLightningWallet() -> LightningWallet {
        let id: String = self.userDefaults.value(forKey: "lightningId") as? String ?? ""
        let name: String = self.userDefaults.value(forKey: "lightningName") as? String ??  ""
        let balance: UInt64 = self.userDefaults.value(forKey: "lightningBalance") as? UInt64 ?? 0
        let transactions: [LNTransaction] = self.userDefaults.value(forKey: "lightningTransactions") as? [LNTransaction] ?? []
        
        return LightningWallet(id: id, name: name, balanceMsats: balance, transactions: transactions)
        
    }
    
    func fetchInitialLightningWalletData() -> RequiredInitialLightningData {
        let id: String = self.userDefaults.value(forKey: "lightningId") as? String ?? ""
        let name: String = self.userDefaults.value(forKey: "lightningName") as? String ??  ""
        
        return RequiredInitialLightningData(id: id, name: name)
    }
}
