//
//  ImportWalletView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 23/07/22.
//


import SwiftUI


struct ImportWalletView: View {
//    @EnvironmentObject var wallet: Wallet
    @EnvironmentObject private var stateController: StateController
    @State var seed: String = ""
    
    var body: some View {
        Content(seed: $seed, importWallet: importWallet)
    }
    
    func importWallet() {
        stateController.importBitcoinWallet(seed: seed)
    }
}

extension ImportWalletView {
    struct Content: View {
        @Binding var seed: String
        let importWallet: () -> Void
        
        var body: some View {
            VStack(spacing: 40){
                
                HStack{
                    Text("Import Wallet")
                        .lilacTitle()
                }
                
                Form {
                    Section(header: Text("Seed Phrase")) {
                        TextEditor(text: $seed)
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

struct ImportWalletView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ImportWalletView.Content(seed: .constant("garbage put upset sunset grass tuna piece language boring unfold swift void"), importWallet: {})
        }
    }
}
