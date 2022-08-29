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
            if stateController.setUpDone {
                WalletView().environmentObject(stateController)
            } else {
                AppStarterView().environmentObject(stateController)
            }
        }
    }
}









