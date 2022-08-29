//
//  LNWalletView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 12/08/22.
//

import SwiftUI

struct LNWalletView: View {
    @EnvironmentObject var stateController: StateController
    
    var body: some View {
        if stateController.lightningWalletExists {
            if stateController.lightningWallet != nil {
                LightningWalletView()
            } else {
                ProgressView()
                    .onAppear(perform: stateController.loadExistingLightningWallet)
            }
        } else {
            SetUpLightningWalletView()
        }
    }
}

extension LNWalletView {
    struct Content: View {
        var walletExists: Bool
        
        var body: some View {
            VStack{
                if walletExists {
                    LightningWalletView()
                } else {
                    SetUpLightningWalletView()
                }
            }
        }
    }
}
        

struct LNWalletView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LNWalletView.Content(walletExists: true)
        }
    }
}
