//
//  CreateNewWalletView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 21/07/22.
//

import SwiftUI

struct StartLightningWalletView: View {
    @EnvironmentObject var stateController: StateController
    
    var body: some View {
        NavigationView {
            Content()
        }
    }
}

extension StartLightningWalletView {
    struct Content: View {
        
        var body: some View {
            VStack(spacing: 40){
                VStack(spacing: 20){
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

struct StartLightningWalletView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView{
                StartLightningWalletView.Content()
            }
        }
    }
}
