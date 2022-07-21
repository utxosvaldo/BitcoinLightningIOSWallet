//
//  CreateNewWalletView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 21/07/22.
//

import SwiftUI

struct CreateNewWalletView: View {
    @EnvironmentObject var wallet: Wallet
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 40){
                VStack(spacing: 20){
                    Text("CryptoMX")
                        .lilacTitle()
                    Text("wallet")
                        .foregroundColor(Color("AccentColor"))
                    
                }

                
                NavigationLink(destination: WalletView().environmentObject(wallet)){
                    PrimaryButton(text: "Create Wallet")
                }
                
                NavigationLink(destination: WalletView().environmentObject(wallet)){
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
        CreateNewWalletView().environmentObject(Wallet())
    }
}
