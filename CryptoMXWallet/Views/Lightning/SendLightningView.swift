//
//  SendLightningView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 23/07/22.
//

import SwiftUI
import Combine
import CodeScanner

struct SendLightningView: View {
    @EnvironmentObject var wallet: Wallet
    @State var invoiceOrAddress: String = ""
    @State private var isShowingScanner = false
    @FocusState private var isAmountFocused: Bool

    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        switch result {
        case .success(let code):
            self.invoiceOrAddress = code
        case .failure(let error):
            print(error)
        }
    }
    

    
    var body: some View {
        VStack{
            
            HStack{
                Text("Send BTC on Lightning")
                    .lilacTitle()
            }
            
            Form {
                Section() {
                    HStack{
                        TextField("Invoice or Address", text: $invoiceOrAddress)
                            .submitLabel(.done)
                            .disableAutocorrection(true)
                        Button(action: {self.isShowingScanner = true}){
                            HStack{
                                Image(systemName: "qrcode.viewfinder")
                                    .font(.largeTitle)
                            }
                        }
                        .sheet(isPresented: $isShowingScanner){
                            CodeScannerView(codeTypes: [.qr], simulatedData: "Testing1234", completion: self.handleScan)
                        }
                    }
                }
            }
//            .onAppear {UITableView.appearance().backgroundColor = .clear}
            
            Spacer()
                
            Button(action: {}){
                PrimaryButton(text: "Send", background: .red)
            }
            .disabled(invoiceOrAddress == "")
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

}

struct SendLightningView_Previews: PreviewProvider {
    static var previews: some View {
        SendLightningView()
    }
}
