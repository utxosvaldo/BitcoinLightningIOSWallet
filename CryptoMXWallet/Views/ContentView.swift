//
//  ContentView.swift
//  TriviaApp
//
//  Created by Osvaldo Rosales Perez on 13/05/22.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var wallet: Wallet
    let repository: WalletRepository
    
    init(){
        self.repository = WalletRepository()
    }
    
    var body: some View {
        
        if repository.doesWalletExist(){
            WalletView().environmentObject(wallet)
        } else {
            CreateNewWalletView().environmentObject(wallet)
        }
        
//        NavigationView {
//            VStack(spacing: 40){
//                VStack(spacing: 20){
//                    Text("CryptoMX")
//                        .lilacTitle()
//                    Text("wallet")
//                        .foregroundColor(Color("AccentColor"))
//                    
//                }
//            
//                
//                NavigationLink(destination: WalletView().environmentObject(wallet)){
//                    PrimaryButton(text: "Create Wallet")
//                }
//                
//                NavigationLink(destination: WalletView().environmentObject(wallet)){
//                    PrimaryButton(text: "Import Wallet")
//                }
//                
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .edgesIgnoringSafeArea(.all)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Wallet())
    }
}
