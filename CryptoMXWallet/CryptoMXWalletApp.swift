//
//  CryptoMXWalletApp.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 01/06/22.
//

import SwiftUI

@main
struct CryptoMXWalletApp: App {
    @StateObject var stateController = StateController()
    
    var body: some Scene {
        WindowGroup {
            if stateController.bitcoinWalletExist {
                WalletView().environmentObject(stateController)
            } else {
                CreateNewWalletView().environmentObject(stateController)
            }
        }
    }
}
