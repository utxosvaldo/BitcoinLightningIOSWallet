//
//  DepositFundsView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 23/07/22.
//

import SwiftUI
import Combine

struct DepositFundsView: View {
    @EnvironmentObject var wallet: Wallet
    @State var amount: String = ""
    @State var showDepositAlert: Bool = false
    @FocusState private var isAmountFocused: Bool
    
    var body: some View {
        VStack(spacing: 40){
            
            HStack{
                Text("Deposit Funds to Lightning")
                    .lilacTitle()
            }
            
            Spacer()
            
            Image(systemName: "plus.circle.fill")
                .foregroundColor(.blue)
                .font(.largeTitle)
            Spacer()
            
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
            }
//            .onAppear {UITableView.appearance().backgroundColor = .clear}
            
            Spacer()
                
            Button(action: {showDepositAlert = true}){
                PrimaryButton(text: "Deposit Funds")
            }
            .disabled((Double(amount) ?? 0) == 0)
            .alert("Confirm Transaction", isPresented: $showDepositAlert){
                Button("Yes", role: .cancel){}
                Button("Cancel"){}
            } message:{
                Text("Are you sure you want to deposit this funds from your bitcoin wallet into lightning?")
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

}

struct DepositFundsView_Previews: PreviewProvider {
    static var previews: some View {
        DepositFundsView()
    }
}
