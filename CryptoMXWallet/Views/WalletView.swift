//
//  NewWalletView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 16/07/22.
//

import SwiftUI

struct WalletView: View {
    @EnvironmentObject var wallet: Wallet
    
    var body: some View {
        VStack{
            TabView {
                BitcoinWalletView()
                    .environmentObject(wallet)
                    .navigationBarHidden(true)
                    .tabItem {
                        Label("Bitcoin", systemImage: "bitcoinsign.circle")
                    }
                LightningWalletView()
                    .environmentObject(wallet)
                    .navigationBarHidden(true)
                    .tabItem {
                        Label("Lightning", systemImage: "bolt.circle")
                    }
            }
        }
    }
}
        

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
            .environmentObject(Wallet())
    }
}
