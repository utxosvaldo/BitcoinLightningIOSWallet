//
//  AppStarterView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 24/08/22.
//

import SwiftUI


struct AppStarterView: View {
    @EnvironmentObject var stateController: StateController
    @State private var goToBitcoin: Bool = false
    
    var body: some View {
        if goToBitcoin {
            SetUpBitcoinWalletView().environmentObject(stateController)
        } else {
            Content(start: start)
        }
    }
    
    func start(){
        goToBitcoin = true
        stateController.signIntoIbex()
    }
}

extension AppStarterView {
    struct Content: View {
        var start: () -> Void
        
        var body: some View {
            VStack(spacing: 40){
                VStack(spacing: 20){
                    Text("CryptoMX")
                        .lilacTitle()
                    Text("wallet")
                        .foregroundColor(Color("AccentColor"))
                }

                Button(action: start){
                    PrimaryButton(text: "Let's start!")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct AppStarterView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView{
                AppStarterView.Content(start: {})
            }
        }
    }
}
