//
//  CreateNewWalletView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 21/07/22.
//

import SwiftUI

struct CreateNewWalletView: View {
    @EnvironmentObject var stateController: StateController
    
    var body: some View {
        
        NavigationView {
            Content(createWallet: createWallet)
        }
    }
    
    func createWallet () {
        stateController.createBitcoinWallet()
    }
}

extension CreateNewWalletView {
    struct Content: View {
        let createWallet: () -> Void
        
        var body: some View {
            VStack(spacing: 40){
                VStack(spacing: 20){
                    Text("CryptoMX")
                        .lilacTitle()
                    Text("wallet")
                        .foregroundColor(Color("AccentColor"))
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

struct CreateNewWalletView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView{
                CreateNewWalletView.Content(createWallet: {})
            }
        }
    }
}
