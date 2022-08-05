//
//  BitcoinWalletView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 20/07/22.
//

import SwiftUI

struct LightningWalletView: View {
    @EnvironmentObject private var stateController : StateController
    
    var body: some View {
        NavigationView {
            Content(balanceText: "", sync: {})
        }
    }
}

extension LightningWalletView {
    struct Content: View {
        let balanceText: String
        let sync: () -> Void
        
        var body: some View {
            VStack(spacing: 10) {
                
                Spacer()
                BalanceDisplay(balanceText: balanceText)
                
                Button(action: sync){
                    PrimaryButton(text: "Sync wallet")
                }
                
//                NavigationLink(destination: TransactionHistoryView()){
                    PrimaryButton(text: "Transaction History")
//                }
                
                HStack{
//                    NavigationLink(destination: ReceiveView()){
                    PrimaryButton(text: "Deposit")
//                    }
//
//                    NavigationLink(destination: SendView()){
                    PrimaryButton(text: "Withdraw")
//                    }
                }
                
                HStack{
//                    NavigationLink(destination: ReceiveView()){
                    PrimaryButton(text: "Receive", background: .green)
//                    }
//
//                    NavigationLink(destination: SendView()){
                    PrimaryButton(text: "Send", background: .red)
//                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Lightning Wallet", displayMode: .automatic)
        }
    }
}
        

struct LightningWalletView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            NavigationView {
                LightningWalletView.Content(balanceText: TestData.bitcoinWallet.balanceText, sync: {})
            }
        }
    }
}
