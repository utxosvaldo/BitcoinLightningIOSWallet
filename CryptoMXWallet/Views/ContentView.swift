//
//  ContentView.swift
//  TriviaApp
//
//  Created by Osvaldo Rosales Perez on 13/05/22.
//

import Foundation
import SwiftUI

struct ContentView: View {
//    @StateObject var triviaManager = TriviaManager()
    @EnvironmentObject var wallet: Wallet
//    @Published var path: String = " asefaf"
    
    
//    func setWallet() {
//        wallet.setPath(pathToSave: NSSearchPathForDirectoriesInDomains(
//        .documentDirectory, .userDomainMask, true
//        ).first!)
//    }
    
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 40){
                VStack(spacing: 20){
                    Text("CryptoMX")
                        .lilacTitle()
                    Text("Are you ready to test out your trivia skills?")
                        .foregroundColor(Color("AccentColor"))
                    
                }
                
                NavigationLink {
                    WalletView()
                        .environmentObject(wallet)
                } label: {
                    PrimaryButton(text: "Create Wallet")
                }
                
                NavigationLink {
                    WalletView()
                        .environmentObject(wallet)
                } label: {
                    PrimaryButton(text: "Import Wallet")
                }
                

                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
        .background(Color(red: 0.9, green: 0.9, blue: 0.8))
        }
//        .onAppear(perform: wallet.setPath(pathToSave: NSSearchPathForDirectoriesInDomains(
//            .documentDirectory, .userDomainMask, true
//        ).first!))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Wallet())
    }
}
