//
//  ReceiveLightningView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 23/07/22.
//

import SwiftUI
import CodeScanner
import Combine

struct ReceiveLightningView: View {
    @EnvironmentObject var wallet: Wallet
    @State var lightningInvoice: String = "Test lightning invoice"
    @State var amount: String = ""
    @State var note: String = ""
    @State private var isShowingScanner = false
    @FocusState private var isAmountFocused: Bool

    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        switch result {
        case .success(let code):
            self.lightningInvoice = code
        case .failure(let error):
            print(error)
        }
    }
    
    private func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    var body: some View {
        VStack{
            
            HStack{
                Text("Receive BTC on Lightning")
                    .lilacTitle()
            }
            
            
            Image(uiImage: generateQRCode(from: lightningInvoice))
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .contextMenu {
                    Button(action: {
                        UIPasteboard.general.string = lightningInvoice}) {
                            Text("Copy to clipboard")
                        }
                }
            
            
            Form {
                
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
                
                
                Section(header: Text("Note")) {
                    HStack{
                        TextField("Add Public Note", text: $note)
                            .submitLabel(.done)
                            .disableAutocorrection(true)
                    }
                }
                
                
                Button(action: {self.isShowingScanner = true}){
                    HStack{
                        Image(systemName: "qrcode.viewfinder")
                            .font(.largeTitle)
                        Text("Scan")
                    }
                }
                .sheet(isPresented: $isShowingScanner){
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Testing1234", completion: self.handleScan)
                }
                
                
                
            }.onAppear {UITableView.appearance().backgroundColor = .clear}
            
            Spacer()
                
            Button(action: {}){
                PrimaryButton(text: "Share", background: .red)
            }
            .disabled(lightningInvoice == "" || (Double(amount) ?? 0) == 0)
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

}

struct ReceiveLightningView_Previews: PreviewProvider {
    static var previews: some View {
        ReceiveLightningView().environmentObject(Wallet())
    }
}
