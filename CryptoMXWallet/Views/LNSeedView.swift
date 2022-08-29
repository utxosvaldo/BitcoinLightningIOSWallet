//
//  LNSeedView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 24/08/22.
//

import SwiftUI

struct LNSeedView: View {
    @EnvironmentObject private var stateController: StateController

    @State private var name: String = ""
    @State private var id: String = ""
    @State private var isInfoShowing: Bool = false
    @State private var isInfoBackedUp: Bool = false
    
    var body: some View {
        Content(name: name, id: id, isInfoShowing: isInfoShowing, showInfo: showInfo, backedUpInfo: backedUpInfo)
    }
    
    func showInfo() {
        id = stateController.lightningWallet.id
        name = stateController.lightningWallet.name
        isInfoShowing = true
    }
    
    func backedUpInfo() {
        stateController.setUpDone = true
    }
}

extension LNSeedView {
    struct Content: View {
        var name: String
        var id: String
        var isInfoShowing: Bool
        var showInfo: () -> Void
        var backedUpInfo: () -> Void
        
        var body: some View {
            VStack(spacing: 40){
                Spacer()
                Text("Please back up your wallet information").lilacTitle()
                if isInfoShowing {
                    Text("Name: \(name)")
                    Text("Id: \(id)")
                    Button(action: backedUpInfo){
                        PrimaryButton(text: "I've backed up my information")
                    }
                } else {
                    Button(action: showInfo){
                        PrimaryButton(text: "Show my wallet information", background: .red)
                    }
                }
                Spacer()
            }
        }
    }
}

struct LNSeedView_Previews: PreviewProvider {
    static var previews: some View {
        LNSeedView.Content(name: TestData.lightningWallet.name, id: TestData.lightningWallet.id, isInfoShowing: false, showInfo: {}, backedUpInfo: {})
    }
}
