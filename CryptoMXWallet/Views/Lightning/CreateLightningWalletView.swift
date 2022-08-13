//
//  CreateLightningWalletView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 12/08/22.
//

import SwiftUI

struct CreateLightningWalletView: View {
    @EnvironmentObject private var stateController: StateController
    @State var name: String = ""
    
    var body: some View {
        Content(name: $name , createWallet: createWallet)
    }
    
    func createWallet() {
        stateController.createLightningWallet(name: name)
    }
}

extension CreateLightningWalletView {
    struct Content: View {
        @Binding var name: String
        let createWallet: () -> Void
        
        var body: some View {
            VStack(spacing: 40){
                
                HStack{
                    Text("Create Wallet")
                        .lilacTitle()
                }
                
                Form {
                    Section(header: Text("Wallet name")) {
                        TextEditor(text: $name)
                            .submitLabel(.done)
                    }.multilineTextAlignment(.leading)
                }
                
                Spacer()
                
                VStack(spacing: 10){
                    Button(action: createWallet){
                        PrimaryButton(text: "Create Wallet", background: .blue)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct CreateLightningWalletView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CreateLightningWalletView.Content(name: .constant(TestData.lightningWallet.name), createWallet: {})
        }
    }
}
