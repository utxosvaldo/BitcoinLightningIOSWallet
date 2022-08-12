//
//  WithdrawFundsView.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 23/07/22.
//

import SwiftUI
import Combine

struct WithdrawFundsView: View {
    @State var amount: String = ""
    @State var showWithdrawAlert: Bool = false
    @FocusState private var isAmountFocused: Bool
    
    var body: some View {
        VStack(spacing: 40){
            
            HStack{
                Text("Withdraw Funds to Lightning")
                    .lilacTitle()
            }
            
            Spacer()
            
            Image(systemName: "minus.circle.fill")
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
                
            Button(action: {showWithdrawAlert = true}){
                PrimaryButton(text: "Withdraw Funds")
            }
            .disabled((Double(amount) ?? 0) == 0)
            .alert("Confirm Transaction", isPresented: $showWithdrawAlert){
                Button("Yes", role: .cancel){}
                Button("Cancel"){}
            } message:{
                Text("Are you sure you want to withdraw this funds from lightning into your bitcoin wallet?")
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

}

struct WithdrawFundsView_Previews: PreviewProvider {
    static var previews: some View {
        WithdrawFundsView()
    }
}
