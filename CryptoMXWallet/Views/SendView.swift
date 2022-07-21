//
//  SendView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 23/06/22.
//)

import SwiftUI
import Combine
import CodeScanner


struct SendView: View {
    @EnvironmentObject var wallet: Wallet
    @State var to: String = ""
    @State var amount: String = "0"
    @State private var isShowingScanner = false
    @FocusState private var isAmountFocused: Bool
    
//    @Environment(\.presentationMode) var presentationMode
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
                    HStack{
                        TextField("Address", text: $to)
                            .submitLabel(.done)
                        Button(action: {self.isShowingScanner = true}){
                            Image(systemName: "camera")
                        }
                        .sheet(isPresented: $isShowingScanner){
                            CodeScannerView(codeTypes: [.qr], simulatedData: "Testing1234", completion: self.handleScan)
                        }
                    }
                }
                Section(header: Text("Amount (Sats)")) {
                    TextField("Amount", text: $amount)
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
                }
                
                
            }
//            .onAppear {UITableView.appearance().backgroundColor = .clear}
            
            Spacer()
            
            VStack(spacing: 10){
//                Button(action: {self.isShowingScanner = true}){
//                    PrimaryButton(text: "Scan Address")
//                }
//                .sheet(isPresented: $isShowingScanner){
//                    CodeScannerView(codeTypes: [.qr], simulatedData: "Testing1234", completion: self.handleScan)
//                }
                
                Button(action: {
                    wallet.broadcastTx(recipient: to, amount: (UInt64(amount) ?? 0))
                }){
                    PrimaryButton(text: "Broadcast Transaction", background: .red)
                }
                .disabled(to == "" || (Double(amount) ?? 0) == 0)
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SendView_Previews: PreviewProvider {
    static var previews: some View {
        SendView()
            .environmentObject(Wallet())
    }
}
