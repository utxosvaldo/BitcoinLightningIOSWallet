//
//  LightningWallet.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 20/07/22.
//

import SwiftUI

struct LightningWalletView: View {
    @EnvironmentObject var wallet: Wallet
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Lightning Wallet").lilacTitle()
            
            Spacer()
            BalanceDisplay(balance: wallet.balanceText)
            
            Button(action: wallet.sync){
                PrimaryButton(text: "Sync wallet")
            }
            
            NavigationLink(destination: TransactionHistoryView()){
                PrimaryButton(text: "Transaction History")
            }
            
            HStack{
                NavigationLink(destination: ReceiveView().environmentObject(wallet)){
                    PrimaryButton(text: "Receive", background: .green)
                }
                NavigationLink(destination: NewSendView().environmentObject(wallet)){
                    PrimaryButton(text: "Send", background: .red)
                }
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
        .padding()
        .onAppear(perform: sync)
    }
}

struct LightningWalletView_Previews: PreviewProvider {
    static var previews: some View {
        LightningWalletView()
            .environmentObject(Wallet())
    }
}
