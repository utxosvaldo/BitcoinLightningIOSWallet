//
//  importLightningWalletView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 12/08/22.
//

import SwiftUI

struct ImportLightningWalletView: View {
//    @EnvironmentObject var wallet: Wallet
    @EnvironmentObject private var stateController: StateController
    @State var id: String = ""
    @State var name: String = ""
    
    var body: some View {
        Content(id: $id, name: $name ,importWallet: importWallet)
    }
    
    func importWallet() {
        stateController.importLightningWallet(id: id, name: name)
    }
}

extension ImportLightningWalletView {
    struct Content: View {
        @Binding var id: String
        @Binding var name: String
        let importWallet: () -> Void
        
        var body: some View {
            VStack(spacing: 40){
                
                HStack{
                    Text("Import Wallet")
                        .lilacTitle()
                }
                
                Form {
                    Section(header: Text("Wallet Name")) {
                        TextEditor(text: $name)
                            .submitLabel(.done)
                    }
                    
                    Section(header: Text("Lightning Id")) {
                        TextEditor(text: $id)
                            .submitLabel(.done)
                    }.multilineTextAlignment(.leading)
                }
    //            .onAppear {UITableView.appearance().backgroundColor = .clear}
                
                Spacer()
                
                VStack(spacing: 10){
                    
                    
                    Button(action: importWallet){
                        PrimaryButton(text: "Import Wallet", background: .blue)
                    }
                }
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct ImportLightningWalletView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ImportLightningWalletView.Content(id:.constant("ab124d8a-f9b8-401e-87f0-f8bbc8188156    "),name: .constant("My Lightning Wallet"), importWallet: {})
        }
    }
}
