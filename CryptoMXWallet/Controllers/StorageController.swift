//
//  StorageController.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 02/08/22.
//

import Foundation

class StorageController {
    private let userDefaults: UserDefaults = UserDefaults.standard
    
//    func saveValue(forKey key: String, value: Any) {
//        self.userDefaults.set(value, forKey: key)
//    }
    
//    func readValue (forKey key: String) -> String {
//        let savedValue = self.userDefaults.value(forKey: key)
//        return String(describing: savedValue)
//    }
//
//    func updateValue(forKey key: String, value: String) {
//        self.userDefaults.set(value, forKey: key)
//    }
//
//    func deleteValue(forKey key: String) {
//        self.userDefaults.removeObject(forKey: key)
//    }
    
    func doesBitcoinWalletExist() -> Bool {
        return self.userDefaults.value(forKey: "bitcoinWalletInitialized") as? Bool ?? false
    }
    
    func saveBitcoinWallet(path: String, descriptor: String, changeDescriptor: String){
        self.userDefaults.set(true, forKey: "bitcoinWalletInitialized")
        self.userDefaults.set(path, forKey: "path")
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
        
        return RequiredInitialData(descriptor: descriptor, changeDescriptor: changeDescriptor)
    }
}
