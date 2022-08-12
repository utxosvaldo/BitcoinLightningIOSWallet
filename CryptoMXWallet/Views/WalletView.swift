//
//  NewWalletView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 16/07/22.
//

import SwiftUI

struct WalletView: View {
    @EnvironmentObject var stateController: StateController
    
    var body: some View {
        VStack{
            TabView {
                BitcoinWalletView()
                    .environmentObject(stateController)
                    .tabItem {
                        Label("Bitcoin", systemImage: "bitcoinsign.circle")
                    }
                StartLightningWalletView()
                    .environmentObject(stateController)
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
            .environmentObject(StateController())
    }
}
