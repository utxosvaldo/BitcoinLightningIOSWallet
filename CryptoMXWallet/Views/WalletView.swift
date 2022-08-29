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
        if stateController.ibexSignedIn {
            Content()
        } else {
            ProgressView()
        }
    }
}

extension WalletView {
    struct Content: View {
        
        var body: some View {
            
            VStack{
                TabView {
                    BitcoinWalletView()
                        .tabItem {
                            Label("Bitcoin", systemImage: "bitcoinsign.circle")
                        }
                    LightningWalletView()
                        .tabItem {
                            Label("Lightning", systemImage: "bolt.circle")
                        }
                }
            }
        }
    }
}
        

//struct WalletView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            WalletView.Content()
//        }
//    }
//}
