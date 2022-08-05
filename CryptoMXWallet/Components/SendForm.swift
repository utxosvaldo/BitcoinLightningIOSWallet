//
//  SendForm.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 04/08/22.
//

import SwiftUI

struct SendForm: View {
    @Binding 
    
    var body: some View {
        Form {
            Section(header: Text("Recipient")){
                HStack {
                    TextField("Address", text: $to)
                }
            }
        }
    }
}

struct SendForm_Previews: PreviewProvider {
    static var previews: some View {
        SendForm()
    }
}
