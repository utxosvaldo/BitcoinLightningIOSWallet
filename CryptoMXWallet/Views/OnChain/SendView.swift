//
//  SendView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 04/08/22.
//

import SwiftUI
import CodeScanner

struct SendView: View {
    @EnvironmentObject private var stateController: StateController
    @State var to: String = ""
    @State var amount: String = ""
    @State private var showScanner = false
    @State private var showBroadcastAlert = false
    
    var body: some View {
        Content(to: $to, amount: $amount, showBroadcastAlert: $showBroadcastAlert, scanQR: scanQR, sendTx: sendTx, broadcastTx: broadcastTx)
            .sheet(isPresented: $showScanner){
                NavigationView {
                    CodeScannerView(codeTypes:[.qr], simulatedData: "test1123", completion: handleScan)
                }
            }
    }
    
    func scanQR(){
        showScanner = true
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>){
        showScanner = false
        switch result {
        case .success(let code):
            to = code
        case .failure(let error):
            print(error)
        }
    }
    
    func sendTx(){
        showBroadcastAlert = true
    }
    
    func broadcastTx() {
        stateController.bitcoinController.broadcastTx(recipient: to, amount: amount.toUInt64)
        showBroadcastAlert = false
    }
}

extension SendView {
    struct Content: View {
        @Binding var to: String
        @Binding var amount: String
        @Binding var showBroadcastAlert: Bool
        @FocusState private var isAmountFocused: Bool
//
        let scanQR: () -> Void
        let sendTx: () -> Void
        let broadcastTx: () -> Void
        
        var body: some View {
            VStack{
                Text("Send Bitcoin")
                    .lilacTitle()
                
                Form {
                    Section(header: Text("Recipient")){
                        HStack {
                            TextField("Address", text: $to)
                                .submitLabel(.done)
                                .disableAutocorrection(true)
                            
                            Button(action: scanQR){
                                Image(systemName: "qrcode")
                                    .imageScale(.large)
                            }
                        }
                    }
                    
                    Section(header: Text("Amount (Sats)")){
                        HStack {
                            TextField("Sats", text: $amount)
                                .focused($isAmountFocused)
                                .keyboardType(.numberPad)
                            DoneButton(isAmountFocused: isAmountFocused, action: {isAmountFocused = false})
                        }
                    }
                }
                
                Button(action: sendTx){
                    PrimaryButton(text: "Broadcast Transaction", background: .red)
                }.alert("Confirm Transaction", isPresented: $showBroadcastAlert){
                    Button("Yes", role: .cancel, action: broadcastTx)
                    Button("Cancel"){}
                } message: {
                    Text("Recipient: \(to) \n Amount: \(amount)")
                }
            }
        }
    }
}


struct SendView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SendView.Content(to: .constant("tb1qc3ehslj4jdjk8u4f06efjvfthgm3jeulkqc8jy"), amount: .constant("1234"), showBroadcastAlert: .constant(true), scanQR: {}, sendTx: {}, broadcastTx: {})
        }
    }
}
