//
//  WalletView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 01/06/22.
//

import SwiftUI

struct WalletView: View {
    @EnvironmentObject var wallet: Wallet
    
    var body: some View {
        
        
        
        VStack(spacing: 40){
            HStack{
                Text("CryptoMX Wallet")
                    .lilacTitle()
            }
            
            VStack(alignment: .leading, spacing: 20) {
                BalanceDisplay(balance: wallet.balanceText)
            }
            
            Button{
                wallet.sync()
            } label: {
                PrimaryButton(text: "Sync Wallet")
            }
            
            
            PrimaryButton(text: "Transaction History")
            
            HStack{
//                NavigationView {
                NavigationLink {
//                    ReceiveView()
//                        .environmentObject(walletManager)
                } label: {
                    PrimaryButton(text: "Receive", background: Color("Receive"))
                }
                
                NavigationLink{
//                    SendView()
//                        .environmentObject(walletManager)
                } label: {
                    PrimaryButton(text: "Send", background: Color("Send"))
                }
            }
            

            
            Spacer()
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Background"))
        .navigationBarHidden(true)
        .onAppear(perform: wallet.createWallet)
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
            .environmentObject(Wallet())
    }
}
