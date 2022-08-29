//
//  CreateNewWalletView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 21/07/22.
//

import SwiftUI

struct SetUpLightningWalletView: View {
    @EnvironmentObject var stateController: StateController
    
    var body: some View {
        if stateController.lightningWalletExists {
            LNSeedView().environmentObject(stateController)
        } else {
            NavigationView {
                Content()
            }
        }
    }
}

extension SetUpLightningWalletView {
    struct Content: View {
        
        var body: some View {
            VStack(spacing: 40){
                VStack(spacing: 20){
                    Text("Set up your")
                        .foregroundColor(Color("AccentColor"))
                    Text("Lightning Wallet")
                        .lilacTitle()
                }
                
                NavigationLink(
                    destination: CreateLightningWalletView()
                ){
                    PrimaryButton(text: "Create Wallet")
                }
                NavigationLink(
                    destination: ImportLightningWalletView()
                ){
                    PrimaryButton(text: "Import Wallet")
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct SetUpLightningWalletView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView{
                SetUpLightningWalletView.Content()
            }
        }
    }
}
