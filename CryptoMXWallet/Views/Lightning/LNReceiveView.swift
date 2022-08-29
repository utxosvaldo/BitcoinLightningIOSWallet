//
//  LNReceiveView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 19/08/22.
//

import SwiftUI

struct LNReceiveView: View {
    @EnvironmentObject private var stateController: StateController
    @State var amount: String = ""
    @State var memo: String = ""
    @State private var showInvoiceSheet = false

    var body: some View {
        Content(amount: $amount, memo: $memo, createInvoice: createInvoice)
            .sheet(isPresented: $showInvoiceSheet){
                if stateController.latestLNInvoice != nil {
                    InvoiceSheetView(showInvoiceSheet: $showInvoiceSheet, amount: amount, memo: memo, lnInvoice: stateController.latestLNInvoice!)
                } else {
                    ProgressView("Creating invoice ...")
                }
            }
            .onAppear(perform: clearLatestInvoice)
    }

    func createInvoice(){
        showInvoiceSheet = true
        stateController.createInvoice(amount: amount, memo: memo)
    }
    
    func clearLatestInvoice(){
        stateController.clearLatestInvoice()
    }
}

extension LNReceiveView {
    struct Content: View {
        @Binding var amount: String
        @Binding var memo: String
        @FocusState private var isAmountFocused: Bool
        
        let createInvoice: () -> Void

        var body: some View {
            VStack{
                Text("Create Lightning Invoice")
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
                    Section(header: Text("Memo")){
                        HStack {
                            TextField("Description", text: $memo)
                                .submitLabel(.done)
                                .disableAutocorrection(true)

                        }
                    }
                }
                Spacer()

                Button(action: createInvoice){
                    PrimaryButton(text: "Create Invoice", background: .blue)
                }
            }
        }
    }
    
    struct InvoiceSheetView: View {
        @Binding var showInvoiceSheet: Bool
        var amount: String
        var memo: String
        var lnInvoice: LNInvoice
        
        var body: some View {
            NavigationView{
                VStack{
                    HStack{
                        Text("Lightning Invoice")
                            .lilacTitle()
                    }
                    Spacer()
                    
                    Image(uiImage: lnInvoice.bolt11.qrcode)
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .onTapGesture {
                            UIPasteboard.general.string = lnInvoice.bolt11
                        }
                    
                    Text("Please pay \(amount) sats")
                    Text("For: \(memo)")
                    Spacer()
                    Text(lnInvoice.bolt11.shortBolt)
                        .contextMenu {
                            Button(action: {
                                UIPasteboard.general.string = lnInvoice.bolt11}) {
                                    Text("Copy Lightning Invoice to clipboard")
                                }
                        }
                    Button(action: {showInvoiceSheet = false}){
                        PrimaryButton(text: "Done")
                    }
                    Spacer()
                }
            }
        }
    }
}


struct LNReceiveView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LNReceiveView.Content(amount: .constant("1234"), memo: .constant("Test invoice"), createInvoice: {})
        }
        
        Group {
            LNReceiveView.InvoiceSheetView(showInvoiceSheet: .constant(false),amount: "1234", memo: "Test Invoice", lnInvoice: TestData.lnInvoice)
        }
    }
}
