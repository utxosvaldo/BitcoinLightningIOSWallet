//
//  StorageController.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 02/08/22.
//

import Foundation

class StorageController {
    private let userDefaults: UserDefaults = UserDefaults.standard
    
    func doesBitcoinWalletExist() -> Bool {
        return self.userDefaults.value(forKey: "bitcoinWalletInitialized") as? Bool ?? false
    }
    
    func doesLightningWalletExist() -> Bool {
        return self.userDefaults.value(forKey: "lightningWalletInitialized") as? Bool ?? false
    }
    
    func saveLightningWallet(id: String, name: String) {
        self.userDefaults.set(true, forKey: "lightningWalletInitialized")
        self.userDefaults.set(id, forKey: "lightningId")
        self.userDefaults.set(name, forKey: "lightningName")
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
    
    func fetchInitialWalletData() -> RequiredInitialData {
        let descriptor: String = self.userDefaults.value(forKey: "descriptor") as? String ?? ""
        let changeDescriptor: String = self.userDefaults.value(forKey: "changeDescriptor") as? String ?? ""
        
        return RequiredInitialData(descriptor: descriptor, changeDescriptor: changeDescriptor, mnemonic: nil)
    }
    
    func fetchInitialLightningWalletData() -> RequiredInitialLightningData {
        let id: String = self.userDefaults.value(forKey: "lightningId") as? String ?? ""
        let name: String = self.userDefaults.value(forKey: "lightningName") as? String ??  ""
        
        return RequiredInitialLightningData(id: id, name: name)
    }
}
