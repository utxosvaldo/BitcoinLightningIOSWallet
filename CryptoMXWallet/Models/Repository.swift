//
//  Respository.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 20/07/22.
//

import Foundation

protocol Repository {
    
    func saveValue(forKey key: String, value: Any)
    func readValue(forKey key: String) -> String
    func updateValue(forKey key: String, value: String)
    func deleteValue(forKey key: String)
    
}

//struct RequiredInitialData {
//    let descriptor: String
//    let changeDescriptor: String
//}

class WalletRepository: Repository {
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func saveValue(forKey key: String, value: Any) {
        self.userDefaults.set(value, forKey: key)
    }
    
    func readValue (forKey key: String) -> String {
        let savedValue = self.userDefaults.value(forKey: key)
        return String(describing: savedValue)
    }
    
    func updateValue(forKey key: String, value: String) {
        self.userDefaults.set(value, forKey: key)
    }
    
    func deleteValue(forKey key: String) {
        self.userDefaults.removeObject(forKey: key)
    }
    
    func doesWalletExist() -> Bool {
        let encodedBoolean = self.readValue(forKey: "walletInitialized")
        let walletInitialized: Bool = (encodedBoolean == "true")
        return walletInitialized
    }
    
    func saveWallet(path: String, descriptor: String, changeDescriptor: String){
        self.saveValue(forKey: "walletInitialized", value: "true")
        self.saveValue(forKey: "path", value: path)
        self.saveValue(forKey: "descriptor", value: descriptor)
        self.saveValue(forKey: "changeDescriptor", value: changeDescriptor)
    }
    
    func saveMnemonic(mnemonic: String) {
        print("Recovery phrase is: \(mnemonic)")
        self.saveValue(forKey: "mnemonic", value: mnemonic)
    }
    
    func getMnemonic() -> String {
        return self.readValue(forKey: "mnemonic")
    }
    
//    func getInitialWalletData() -> RequiredInitialData {
//        let descriptor: String = self.readValue(forKey: "descriptor")
//        let changeDescriptor: String = self.readValue(forKey: "changeDescriptor")
//        
//        return RequiredInitialData(descriptor: descriptor, changeDescriptor: changeDescriptor)
//    }
    
}
