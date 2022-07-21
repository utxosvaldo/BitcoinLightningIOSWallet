//
//  Respository.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 20/07/22.
//

import Foundation

protocol Repository {
    
    func saveValue(forKey key: String, value: String)
    func readValue(forKey key: String) -> Any?
    func updateValue(forKey key: String, value: String)
    func deleteValue(forKey key: String)
    
}

class WalletRepository: Repository {
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func saveValue(forKey key: String, value: String) {
        self.userDefaults.set(value, forKey: key)
    }
    
    func readValue(forKey key: String) -> Any? {
        return self.userDefaults.value(forKey: key)
    }
    
    func updateValue(forKey key: String, value: String) {
        self.userDefaults.set(value, forKey: key)
    }
    
    func deleteValue(forKey key: String) {
        self.userDefaults.removeObject(forKey: key)
    }
    
    func doesWalletExist() -> Bool {
        if self.readValue(forKey: "walletInitialized") != nil  {
            return true
        }
        return false
    }
    
}
