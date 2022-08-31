//
//  LNSendView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 30/08/22.
//

import SwiftUI
import CodeScanner

struct LNSendView: View {
    @EnvironmentObject private var stateController: StateController
    @State var invoice: String = ""
    @State var amount: String = ""
    @State var memo: String = ""
    @State var paymentReceipt: LNInvoiceReceipt!
    @State private var showScanner = false
    @State private var showBroadcastAlert = false
    @State private var showHandleScanProgress = false
    
    var body: some View {
        
        if stateController.decodingInvoice{
            ProgressView()
        } else {
            Content(invoice: $invoice, amount: $amount, memo: $memo, showBroadcastAlert: $showBroadcastAlert, scanQR: scanQR, payInvoice: payInvoice, broadcastPayment: broadcastPayment)
                .sheet(isPresented: $showScanner){
                    NavigationView {
                        CodeScannerView(codeTypes:[.qr], simulatedData: "test1123", completion: handleScan)
                    }
                }
        }
    }
    
    func scanQR(){
        showScanner = true
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>){
        Task {
            switch result {
            case .success(let code):
                if let details: DecodedLNInvoice = try? await stateController.decodeInvoice(bolt11: code) {
                    DispatchQueue.main.async {
                        self.invoice = code
                        self.amount = String(details.amountMsat/1000)
                        self.memo = details.description
                        self.showScanner = false
                    }
                } else {
                    DispatchQueue.main.async {
                        self.invoice = code
                        self.amount = "no amount"
                        self.memo = "Could not decode invoice"
                        self.showScanner = false
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
//        showHandleScanProgress = true
        
    }
    
    func payInvoice(){
        showBroadcastAlert = true
    }
    
    func broadcastPayment() {
        showBroadcastAlert = false
        stateController.payInvoice(bolt11: invoice, amountMsat: amount.toUInt64*1000)
        
    }
}

extension LNSendView {
    struct Content: View {
        @Binding var invoice: String
        @Binding var amount: String
        @Binding var memo: String
        @Binding var showBroadcastAlert: Bool
        @FocusState private var isAmountFocused: Bool
//
        let scanQR: () -> Void
        let payInvoice: () -> Void
        let broadcastPayment: () -> Void
        
        var body: some View {
            VStack{
                Text("Pay Lightning Invoice")
                    .lilacTitle()
                
                Form {
                    Section(header: Text("Amount (Sats)")){
                        HStack {
                            TextField("Sats", text: $amount)
                                .focused($isAmountFocused)
                                .keyboardType(.numberPad)
                            DoneButton(isAmountFocused: isAmountFocused, action: {isAmountFocused = false})
                        }
                    }
                    Section(header: Text("Invoice")){
                        HStack {
                            TextField("Lightning invoice", text: $invoice)
                                .submitLabel(.done)
                                .disableAutocorrection(true)
                            
                            Button(action: scanQR){
                                Image(systemName: "qrcode")
                                    .imageScale(.large)
                            }
                            Text("Scan").foregroundColor(.blue)
                        }
                    }
                    
                    Text("\(memo)")
                    
                }
                
                Button(action: payInvoice){
                    PrimaryButton(text: "Pay", background: .blue)
                }.alert("Confirm Payment", isPresented: $showBroadcastAlert){
                    Button("Yes", role: .cancel, action: broadcastPayment)
                    Button("Cancel"){}
                } message: {
                    Text("Payment amount: \(amount) \nMemo: \(memo) \nBolt11 invoice: \(invoice)")
                }
            }
        }
    }
}


struct LNSendView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LNSendView.Content(invoice: .constant(TestData.lnInvoice.bolt11), amount: .constant("12345"), memo: .constant("Test invoice"), showBroadcastAlert: .constant(false), scanQR: {}, payInvoice: {}, broadcastPayment: {})
        }
    }
}
