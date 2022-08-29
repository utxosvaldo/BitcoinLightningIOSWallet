//
//  CreateNewWalletView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 21/07/22.
//

import SwiftUI

struct SetUpBitcoinWalletView: View {
    @EnvironmentObject var stateController: StateController
    
    var body: some View {
        
        if stateController.bitcoinWalletExists {
            SeedView().environmentObject(stateController)
        } else {
            NavigationView {
                Content(createWallet: createWallet)
            }
        }
    }
    
    func createWallet () {
        stateController.createBitcoinWallet()
    }
}

extension SetUpBitcoinWalletView {
    struct Content: View {
        let createWallet: () -> Void
        
        var body: some View {
            VStack(spacing: 40){
                VStack(spacing: 20){
                    Text("Set up your")
                        .foregroundColor(Color("AccentColor"))
                    Text("Bitcoin Wallet")
                        .lilacTitle()
                }

                Button(action: {
                    createWallet()
                }){
                    PrimaryButton(text: "Create Wallet")
                }
                
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

struct SetUpBitcoinWalletView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView{
                SetUpBitcoinWalletView.Content(createWallet: {})
            }
        }
    }
}
