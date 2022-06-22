//
//  ReceiveView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 22/06/22.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

let context = CIContext()
let filter = CIFilter.qrCodeGenerator()

struct ReceiveView: View {
    @EnvironmentObject var wallet: Wallet
//    @State private var address: String = "tb1qfafsasdfasd"
    
    
    func splitAddress(address: String) -> (String, String) {
        let length = address.count
        
        return (String(address.prefix(length / 2)), String(address.suffix(length / 2)))
    }
    
//    func getAddress() {
//        switch viewModel.state {
//            case .loaded(let wallet, _):
//                do {
//                    address = wallet.getNewAddress()
//                }
//            default: do { }
//        }
//    }
    
    func generateQRCode(from string: String) -> UIImage {
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
        BackgroundWrapper {
            Spacer()
            VStack {
                Image(uiImage: generateQRCode(from: "bitcoin:\(viewModel.latestAddress)"))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Spacer()
                Text(splitAddress(address: viewModel.latestAddress).0).textStyle(BasicTextStyle())
                Text(splitAddress(address: viewModel.latestAddress).1).textStyle(BasicTextStyle())
                Spacer()
            }.contextMenu {
                Button(action: {
                    UIPasteboard.general.string = viewModel.latestAddress}) {
                        Text("Copy to clipboard")
                    }
            }
            Spacer()
            BasicButton(action: viewModel.getNewAddress, text: "Generate new address", color: "Green")
        }
        .navigationBarTitle("Receive Address")
        .modifier(BackButtonMod())
        .onAppear(perform: viewModel.getNewAddress)
    }
}

struct ReceiveView_Previews: PreviewProvider {
    static var previews: some View {
        ReceiveView()
    }
}
