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
            Content(balance:stateController.lightningWallet.balanceBtc, sync: sync)
        }
    }
    
    func sync() {
        stateController.syncLightning()
    }
}

extension LightningWalletView {
    struct Content: View {
        var balance: String
        let sync: () -> Void
        
        var body: some View {
            VStack(spacing: 10) {
                
                Text("Lightning Wallet").lilacTitle()
                
                Spacer()
                BalanceDisplay(balanceText: balance)
                
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
                    NavigationLink(destination: LNReceiveView()){
                    PrimaryButton(text: "Receive", background: .green)
                    }
//
//                    NavigationLink(destination: SendView()){
                    PrimaryButton(text: "Send", background: .red)
//                    }
                }
                
                Spacer()
            }
            .padding()
//            .navigationBarTitle("Lightning Wallet", displayMode: .automatic)
        }
    }
}
        

struct LightningWalletView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            NavigationView {
                LightningWalletView.Content(balance: TestData.lightningWallet.balanceBtc, sync: {})
            }
        }
    }
}
