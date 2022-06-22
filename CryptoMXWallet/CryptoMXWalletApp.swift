//
//  CryptoMXWalletApp.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 01/06/22.
//

import SwiftUI

@main
struct CryptoMXWalletApp: App {
    @StateObject var wallet = Wallet()
    // Initialize wallet object (singleton) with path variable
    
    // Initialize shared preferences manager object (singleton)
    
    // Initialize Repository object with shared preferences
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(wallet)
        }
    }
}
