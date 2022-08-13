//
//  IbexHub.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 10/08/22.
//

import Foundation

//extension URLRequest {
//    var ibexHubAPI: URLRequest {
//        var ibexRequest: URLRequest = self
//        ibexRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        ibexRequest.setValue(accessToken, forHTTPHeaderField: "Authorization")
//        return ibexRequest
//    }
//}

class IbexHubAPI {
    private let baseUrl: String = "https://ibexhub.ibexmercado.com"
    private let accessToken: String = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjAzNTAzMzMsIklEIjoiIiwiVHlwZSI6ImFjY2VzcyIsIlVzZXJJRCI6IjE5ZjUyMDY0LWM4MTUtNDc0Yy1iNGRkLTgwNTUyYzMwYjc4MyIsIlBlcm1pc3Npb25zIjpudWxsLCJQb29sIjoiSUJFWF9IVUIifQ.Z-hQj6OGWGx9Bp66VGUvfsWfsuBkUhkB4TX9Hdxnh2a7jz7OnVLMGA1mntFH1A0K5ZCECTGK4L_EJR3PswyGatIVsX0FBnee9zomoe82S43oUkUJKU3oo6aVqd1jpyCodPcmvZkw-QKx__URU6KPaUp0ovT1s7KeKYbPTBFFWQSnUYz2kWHR1rqklk3Qge6Lwyny0PR-aTN9klwPCMV1J4j5K18edhXyal_8P-PTThI0X3ABcIYydoZzlGTY7-ST_mnsXiQQh-FN7P4j48cJw9YkerawKY6h_jgPaOP_18xZ96x9DNsZR0H7GXeak6f4SqMsddoWRlOnpd6EnRbc3MZwoTuZsZM3FMtiWTcTbyt-WcWEJY0S5JBP7DcVAIdGS1YYgerMxMu5m3-nszRY7MFBYz-3eivtoCN1glFT9Z0hFF_aLDHHH9-CHEc-TphaLdDmz5JMUzz-ZIfw9QR6Frpep8ac0CCGXoPc6xjbYhNT3rKL6TL1xia5QYryYlqLsDgt3ohOTehoCAtjYVEk1jWIfKhnCdoLEgxOst8s1wtrf6f5cduUbB8nhCIjUDanV7GDeEh7DReA34SWuPkxafF_e6AULB4mLICqxmrctYKcJpLJUaDHD7mAA243DsbgXPtR1X06_O-Jap7NnOgXM9GHtGduKWvYBzf5_yLPwcY"
    
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
    
    func getAccountDetails(accountId: String) async throws -> IbexAccount {
        let url = URL(string: baseUrl + "/account/\(accountId)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(accessToken, forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(IbexAccount.self, from: data)
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
    
    
    

}
