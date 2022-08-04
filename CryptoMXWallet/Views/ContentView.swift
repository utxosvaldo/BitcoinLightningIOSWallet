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
    var repository: WalletRepository = WalletRepository()
    
    var body: some View {
        if repository.doesWalletExist(){
            WalletView().environmentObject(wallet)
        } else {
            CreateNewWalletView().environmentObject(wallet)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Wallet())
    }
}
