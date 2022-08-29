//
//  SetUpLightningWalletView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 24/08/22.
//

import SwiftUI

struct SetUpLightningWalletView: View {
    @EnvironmentObject var stateController: StateController
    
    @State private var lightningWalletCreated: Bool = false
    
    var body: some View {
        
        if stateController.lightningWalletExists {
            SeedView().environmentObject(stateController)
        } else {
            NavigationView {
                Content(createWallet: createWallet)
            }
        }
    }
    
    func createWallet () {
        stateController.createLightningWallet()
    }
}

extension SetUpLightningWalletView {
    struct Content: View {
        let createWallet: () -> Void
        
        var body: some View {
            VStack(spacing: 40){
                VStack(spacing: 20){
                    Text("Set up your")
                        .foregroundColor(Color("AccentColor"))
                    Text("Lightning Wallet")
                        .lilacTitle()
                }

                Button(action: {
                    createWallet()
                }){
                    PrimaryButton(text: "Create Wallet")
                }
                
                NavigationLink(destination: <#T##() -> Destination#>, label: <#T##() -> Label#>
                
                NavigationLink(
                    destination: ImportWalletView()
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
                SetUpLightningWalletView.Content(createWallet: {})
            }
        }
    }
}
