//
//  NewoldSendView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 18/07/22.
//

import SwiftUI
import Combine
import CodeScanner


struct oldSendView: View {
    @EnvironmentObject var wallet: Wallet
    @State var to: String = ""
    @State var amount: String = ""
    @State private var isShowingScanner = false
    @State private var showBroadcastAlert = false
    @FocusState private var isAmountFocused: Bool

    
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
        VStack{
            
            HStack{
                Text("Send Bitcoin")
                    .lilacTitle()
            }
            
            
            Form {
                Section(header: Text("Recipient")) {
                    HStack{
                        TextField("Address", text: $to)
                            .submitLabel(.done)
                            .disableAutocorrection(true)
                        Button(action: {self.isShowingScanner = true}){
                            Image(systemName: "camera")
                        }
                        .sheet(isPresented: $isShowingScanner){
                            CodeScannerView(codeTypes: [.qr], simulatedData: "Testing1234", completion: self.handleScan)
                        }
                    }
                }
                
                Section(header: Text(isAmountFocused ? "Amount (sats)" : "Amount")) {
                    HStack{
                        TextField("Sats", text: $amount)
                            .focused($isAmountFocused)
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
                        Button(action: {isAmountFocused = false}){
                            Text({isAmountFocused ? "Done" : ""}())
                        }
                    }
                    
                }
            }.onAppear {UITableView.appearance().backgroundColor = .clear}
            
            Spacer()
                
            Button(action: {
                showBroadcastAlert = true
            }){
                PrimaryButton(text: "Broadcast Transaction", background: .red)
            }
            .alert("Confirm Transaction", isPresented: $showBroadcastAlert){
                Button("Yes", role: .cancel){
                    wallet.broadcastTx(recipient: to, amount: (UInt64(amount) ?? 0))
                }
                Button("Cancel"){}
            } message:{
                Text("Are you sure you want to broadcast this transaction?")
            }
            .disabled(to == "" || (Double(amount) ?? 0) == 0)
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct oldSendView_Previews: PreviewProvider {
    static var previews: some View {
        oldSendView()
    }
}
