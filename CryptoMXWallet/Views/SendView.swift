//
//  SendView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 23/06/22.
//

import SwiftUI
import Combine
import CodeScanner


struct SendView: View {
    @EnvironmentObject var wallet: Wallet
    @State var to: String = ""
    @State var amount: String = "0"
    @State private var isShowingScanner = false
    
    @Environment(\.presentationMode) var presentationMode
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
       self.isShowingScanner = false
        switch result {
        case .success(let code):
            self.to = code
        case .failure(let error): 
            print(error)
        }
    }
    
    var body: some View {
        VStack(spacing: 40){
            
            HStack{
                Text("Send Bitcoin")
                    .lilacTitle()
            }
            
            Form {
                Section(header: Text("Recipient")) {
                    TextField("Address", text: $to)
//                        .modifier(BasicTextFieldStyle())
                }
                Section(header: Text("Amount")) {
                    TextField("Amount (sats)", text: $amount)
                        .keyboardType(.numberPad)
                        .onReceive(Just(amount)) { newValue in
                            print("new value: \(newValue)")
                            let filtered = newValue.filter {
                                "0123456789".contains($0)
                            }
                            print("filtered: \(filtered)")
                            if filtered != newValue {
                                self.amount = filtered
                                print("filtered amount: \(amount)")
                            }
                        }
                }
            }.onAppear {UITableView.appearance().backgroundColor = .clear}
            
            Spacer()
            BasicButton(action: { self.isShowingScanner = true}, text: "Scan Address")
            BasicButton(action: {
                wallet.broadcastTx(recipient: to, amount: (UInt64(amount) ?? 0))
                presentationMode.wrappedValue.dismiss()
            }, text: "Broadcast Transaction", color: "Red").disabled(to == "" || (Double(amount) ?? 0) == 0)
            
//            Button{
//                wallet.broadcastTx(recipient: to, amount: UInt64(UInt64(amount) ?? 0))
//            } label: {
//                PrimaryButton(text: "Broadcast Transaction", background: Color("Send"))
//            }
//            .disabled(to == "" || (Double(amount) ?? 0) == 0)
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Background"))
    }
}

struct SendView_Previews: PreviewProvider {
    static var previews: some View {
        SendView()
            .environmentObject(Wallet())
    }
}
