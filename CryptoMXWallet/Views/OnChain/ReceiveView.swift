//
//  newReceiveView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 03/08/22.
//

import SwiftUI

struct ReceiveView: View {
    @EnvironmentObject private var stateController: StateController
    
    var body: some View {
        Content(receiveAddress: stateController.bitcoinWallet.lastUnusedAddress)
    }
}

extension ReceiveView {
    struct Content: View {
        let receiveAddress: String
        
        var body: some View {
            VStack(spacing:40){
                HStack{
                    Text("Receive Bitcoin")
                        .lilacTitle()
                }
                Spacer()
                
                Image(uiImage: receiveAddress.qrcode)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .onTapGesture {
                        UIPasteboard.general.string = receiveAddress
                    }
                
                Text(receiveAddress)
                    .contextMenu {
                        Button(action: {
                            UIPasteboard.general.string = receiveAddress}) {
                                Text("Copy Address to clipboard")
                            }
                    }
//                    .onTapGesture {
//                        UIPasteboard.general.string = receiveAddress
//                    }
                
                Spacer()
                
                Button(action: {}){
                    Text("Receive with amount")
                }
                
                
            }
        }
    }
}

struct ReceiveView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ReceiveView.Content(receiveAddress: TestData.bitcoinWallet.lastUnusedAddress)
        }
    }
}
