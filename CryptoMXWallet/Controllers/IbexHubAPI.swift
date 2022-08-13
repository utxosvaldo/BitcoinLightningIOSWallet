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
    private let accessToken: String = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjA0MzM3MTMsIklEIjoiIiwiVHlwZSI6ImFjY2VzcyIsIlVzZXJJRCI6IjE5ZjUyMDY0LWM4MTUtNDc0Yy1iNGRkLTgwNTUyYzMwYjc4MyIsIlBlcm1pc3Npb25zIjpudWxsLCJQb29sIjoiSUJFWF9IVUIifQ.cgx3nNtsB51dhkVbWZKCu_f3goByHtwMpxy1A8IXEuxGw0KFgrOYIAUFAWiEZ23f0_InS-cUNLG6ER1ckdhbWoJclh98frF_ovcC2lWXwiz8i0e5J1hieFGoiLUSED8HDRdZd1JVqh88IexnkbbCoXX65vPlHyY8Tm619cItTm1n9m1eU-96hPFbYATvw1yOPmqw2vvUtpFi2xEP2z21K_hn-WjwgkX_D87VGRZrNsm0LlzrdNeLNPH5if570ib-yE6RuWSdJ73_IYW0-IxnqbrkBzP1aYZelHagPm5SNOfQDqc1JfiQVqXeysn0V0BIakaQmr7K87VZe1zlHsm396PdgiolQ0ZnP1NqS_NW6lJuHnxhE4OkpuatUxDZkzB6rWgmTcIQc0V7ktLMc3mbkejzbGSIYRofLX3QONAwzcIn3-zHNqu2_cdNAKjOpN_MBH_j4YYaH2VQYKzuNaedg-iAU4sB23P455n1VRIgbECv7rqcs6iYYTKZz095Jd81W9-E2Vpo4pIscPBsRpajGSOaqe0mF1kwPb13RCYLezn36Xc3fDo9qlfIzvyTFMH3jCKgZsKIARqObQmBaHNtFvdnMDjaKsLQonaPgfHSmS47eJo1UIEYsNZpPtqhofFfs3yYE_yXtyLQxgYBsvTWm8C2QIzFMFDXOXS9p0Imw88"
    
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
        request.httpMethod = "POST"
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
