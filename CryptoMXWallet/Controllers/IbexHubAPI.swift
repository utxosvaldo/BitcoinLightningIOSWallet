//
//  IbexHub.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 10/08/22.
//

import Foundation

//extension URLRequest {
//    var ibexPOST: URLRequest {
//        var ibexRequest: URLRequest = self
//
//        request.httpMethod = "POST"
//        ibexRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        ibexRequest.setValue(accessToken, forHTTPHeaderField: "Authorization")
//        return ibexRequest
//    }
//}

class IbexHubAPI {
    private let baseUrl: String = "https://ibexhub.ibexmercado.com"
    private(set) var accessToken: String!
    
//    init(accessToken: String){
//        self.accessToken = accessToken
//    }
    
    func updateAccessToken(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func getAccessToken() async throws -> Auth {
        let baseUrl = "https://ibexhub.ibexmercado.com"
        let url = URL(string: baseUrl + "/auth/signin")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: AnyHashable] = [
            "email": "osvaldo.rosales.96@gmail.com",
            "password": "Lightning69!"
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let auth = try JSONDecoder().decode(Auth.self, from: data)
//        accessToken = auth.accessToken
//        print("Got accessToken: \(String(describing: accessToken))")
        return auth
    }
    
    func createIbexAccount(name: String) async throws -> IbexAccount {
        let url = URL(string: baseUrl + "/account/create")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(accessToken, forHTTPHeaderField: "Authorization")
        
        let body: [String: AnyHashable] = [
            "name": name,
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(IbexAccount.self, from: data)
    }
    
    func getAccountDetails(accountId: String) async throws -> IbexAccountDetails {
        let url = URL(string: baseUrl + "/account/\(accountId)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(accessToken, forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode(IbexAccountDetails.self, from: data)
    }
    
    func getLatestTransactions(accountId: String) async throws -> [LNTransaction] {
        let url = URL(string: baseUrl + "/transactions/\(accountId)/latest")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(accessToken, forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([LNTransaction].self, from: data)
    }
    
    func addInvoice(accountId: String, amountMsat: UInt64, memo: String) async throws -> LNInvoice {
        let url = URL(string: baseUrl + "/invoice/add")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(accessToken, forHTTPHeaderField: "Authorization")
        
        let body: [String: AnyHashable] = [
            "amountMsat": amountMsat,
            "accountId": accountId,
            "memo": memo,
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(LNInvoice.self, from: data)
    }
    
    func payInvoice(accountId: String, bolt11: String, amountMsat: UInt64) async throws -> LNInvoiceReceipt {
        let url = URL(string: baseUrl + "/invoice/add")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(accessToken, forHTTPHeaderField: "Authorization")
        
        let body: [String: AnyHashable] = [
            "accountId": accountId,
            "bolt11": bolt11,
            "amountMsat": amountMsat,
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(LNInvoiceReceipt.self, from: data)
    }
    
    func getInvoiceInfoWithBolt11(bolt11: String) async throws -> LNInvoiceDetails{
        let url = URL(string: baseUrl + "/invoice/from-bolt11/\(bolt11)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(accessToken, forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(LNInvoiceDetails.self, from: data)
    }

}
