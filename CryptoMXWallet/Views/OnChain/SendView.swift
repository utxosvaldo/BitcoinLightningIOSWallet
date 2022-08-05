//
//  SendView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 04/08/22.
//

import SwiftUI

struct SendView: View {
    @EnvironmentObject private var stateController: StateController
    @State var to: String = ""
    @State var amount: String = ""
    
    var body: some View {
        Content(to: $to, amount: $amount, scanQR: {})
    }
}

extension SendView {
    struct Content: View {
        @Binding var to: String
        @Binding var amount: String
//
        let scanQR: () -> Void
        
        var body: some View {
            VStack{
                Text("Send Bitcoin")
                    .lilacTitle()
                
                Form {
                    Section(header: Text("Recipient")){
                        HStack {
                            TextField("Address", text: $to)
                            Button(action: scanQR){
                                Image(systemName: "qrcode")
                            }
                        }
                    }
                    
                    Section(header: Text("Amount (Sats)")){
                        HStack {
                            TextField("Sats", text: $amount)
                            Button(action: {}){
                                Text("Done")
                            }
                        }
                    }
                }
            }
        }
    }
}

//extension SendView.Content {
//    struct SendForm: View {
//        let
//    }
//}

struct SendView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SendView.Content(to: .constant("tb1qc3ehslj4jdjk8u4f06efjvfthgm3jeulkqc8jy"), amount: .constant("1234"), scanQR: {})
        }
    }
}
