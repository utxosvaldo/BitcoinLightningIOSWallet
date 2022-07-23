//
//  ImportWalletView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 23/07/22.
//


import SwiftUI


struct ImportWalletView: View {
    @EnvironmentObject var wallet: Wallet
    @State var seed: String = ""

    func handleSeedPhrase(seed: String){
        
    }
    
    var body: some View {
        VStack(spacing: 40){
            
            HStack{
                Text("Import Wallet")
                    .lilacTitle()
            }
            
            Form {
                Section(header: Text("Seed Phrase")) {
                    HStack{
                        TextField("24 words", text: $seed)
                            .submitLabel(.done)
//                        Button(action: {}){
//                            Image(systemName: "camera")
//                        }
                    }
                }
            }
//            .onAppear {UITableView.appearance().backgroundColor = .clear}
            
            Spacer()
            
            VStack(spacing: 10){
                
                NavigationLink(destination: WalletView().environmentObject(wallet)){
                    PrimaryButton(text: "Import Wallet", background: .blue)
                }
                
//                Button(action: {}){
//                    PrimaryButton(text: "Import Wallet", background: .blue)
//                }
//                .disabled(to == "" || (Double(amount) ?? 0) == 0)
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ImportWalletView_Previews: PreviewProvider {
    static var previews: some View {
        ImportWalletView()
            .environmentObject(Wallet())
    }
}
