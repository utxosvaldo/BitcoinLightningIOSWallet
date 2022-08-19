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
    private let accessToken: String = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjA5MjMwMjgsIklEIjoiIiwiVHlwZSI6ImFjY2VzcyIsIlVzZXJJRCI6IjE5ZjUyMDY0LWM4MTUtNDc0Yy1iNGRkLTgwNTUyYzMwYjc4MyIsIlBlcm1pc3Npb25zIjpudWxsLCJQb29sIjoiSUJFWF9IVUIifQ.qd0JzPFOoDyt1LsBco0_WWtrMnhwYj62cKyx-k7EFm7vB6RUI3EyClEfudn-eNAs8DLOSyvwTwQ6oAaBCUTLCHfQ-WjyHJ4nmOpfPjfZN688M2vmuHjd5xU4Yq5rt3qoiFexzHIwc6wVtWF6AkQyLTqjDSvGgsrak6VFRSGirnqD-MA5bU2UQApfOpX2GIq39cgsmcIUP7lHS0EMX-_WF5NcN71PLwGOJTuJQq9tCDHC_QRM4VY61Gx8E_1yWY3g232JXy999eK4sFyyL8FC2twyrgBfEkGYbLs6PGK2G2lNnm3KxHk_nvDTPdiw7WA7E3K27YvdCQ4JPLs7cxso-Gsoy_uexCvvyTsm9Oncb_91d-41BUvSUydRbSL2I7ETKyyU0QKMMAECuD-VO3xH50m_jQbfcsBr1v1mt40c-QInI3cCGLOIxEd8cbPqzZqn9QJB0IGiROb3GeH89jG0bXHOD_URT2BjffSNkzokCZM5TIoVKc_Hf7iLBgv3nV-oViTIDlNrb4MtqGI-FZ_XM57anKrGwyVTf4sKeUKU4sTNjNCZtT5DRaR_nqRadF31zSo9rj2ss-YACDU85VIdqV88odIXAjaPJFcK6ZIuNoqcu82caRWiED1RSvNLUR7CD4a9k80EiRyGQtjkH034oZ5RSvJ1wyCEOlkdm8Hbl4Q"
    
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
