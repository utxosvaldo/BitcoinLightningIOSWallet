//
//  SeedView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 24/08/22.
//

import SwiftUI

struct SeedView: View {
    @EnvironmentObject private var stateController: StateController

    @State private var mnemonic: String = ""
    @State private var isMnemonicShowing: Bool = false
    @State private var isMnemonicBackedUp: Bool = false
    
    var body: some View {
        if isMnemonicBackedUp {
            SetUpLightningWalletView().environmentObject(stateController)
        } else {
            Content(mnemonic: mnemonic, isMnemonicShowing: isMnemonicShowing,showMnemonic: showMnemonic, backedUpWords: backedUpWords)
        }
    }
    
    func showMnemonic() {
        mnemonic = stateController.getMnemonic()
        isMnemonicShowing = true
    }
    
    func backedUpWords(){
        isMnemonicBackedUp = true
    }
}

extension SeedView {
    struct Content: View {
        var mnemonic: String
        var isMnemonicShowing: Bool
        var showMnemonic: () -> Void
        var backedUpWords: () -> Void
        
        var body: some View {
            VStack(spacing: 40){
                Spacer()
                Text("Please back up your 12 words").lilacTitle()
                if isMnemonicShowing {
                    Text(mnemonic)
                    Button(action: backedUpWords){
                        PrimaryButton(text: "I've backed up my 12 words")
                    }
                } else {
                    Button(action: showMnemonic){
                        PrimaryButton(text: "Show my 12 words", background: .red)
                    }
                }
                Spacer()
            }
        }
    }
}

struct SeedView_Previews: PreviewProvider {
    static var previews: some View {
        SeedView.Content(mnemonic: "damage turtle jeans afraid total raw limit valley extend student train hero", isMnemonicShowing: false, showMnemonic: {}, backedUpWords: {})
    }
}
