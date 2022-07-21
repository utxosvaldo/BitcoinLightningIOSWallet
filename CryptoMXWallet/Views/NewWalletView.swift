//
//  NewWalletView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 16/07/22.
//

import SwiftUI

struct WalletView: View {
    @EnvironmentObject var wallet: Wallet
    
    func sync() {
        if wallet.bdkWallet == nil {
            wallet.createWallet()
        }
        wallet.sync()
    }
    
    var body: some View {
        VStack(spacing: 40) {
            Text("CryptoMX Wallet").lilacTitle()
            
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
        

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
            .environmentObject(Wallet())
    }
}
