//
//  CryptoMXWalletApp.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 01/06/22.
//

import SwiftUI

@main
struct CryptoMXWalletApp: App {
//    @StateObject var wallet = Wallet()
    @StateObject var wallet: Wallet = Wallet()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(wallet)
                .onAppear(perform: onCreate)
        }
    }
    
    func onCreate(){
        // Set path
        wallet.setPath(pathToSave:NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!)
        
        //
    }
}
