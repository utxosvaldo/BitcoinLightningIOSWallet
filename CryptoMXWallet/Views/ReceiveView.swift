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
//    var address : String = "Generate new address"

    
    func updateAddress() {
        wallet.getLastUnusedAddress()
        wallet.getNewAddress()
    }
    
    func splitAddress(address: String) -> (String, String) {
        let length = address.count
        
        return (String(address.prefix(length / 2)), String(address.suffix(length / 2)))
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
        VStack(spacing: 40){
            Spacer()
            VStack {
                Image(uiImage: generateQRCode(from: "bitcoin:\(wallet.latestAddress)"))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Spacer()
//                Text(wallet.latestAddress)
                Text(splitAddress(address: wallet.latestAddress).0).textStyle(BasicTextStyle())
                Text(splitAddress(address: wallet.latestAddress).1).textStyle(BasicTextStyle())
                
                Spacer()
            }.contextMenu {
                Button(action: {
                    UIPasteboard.general.string = wallet.latestAddress}) {
                        Text("Copy to clipboard")
                    }
            }
            Spacer()
            
            Button{
                updateAddress()
            } label: {
                PrimaryButton(text: "Generate new address")
            }
        }
        .navigationBarTitle("Receive Address")
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Background"))
//        .modifier(BackButtonMod())
        .onAppear(perform: updateAddress)
    }
}

struct ReceiveView_Previews: PreviewProvider {
    static var previews: some View {
        ReceiveView()
            .environmentObject(Wallet())
    }
}
