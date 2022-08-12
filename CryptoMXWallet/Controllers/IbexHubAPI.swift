//
//  IbexHub.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 10/08/22.
//

import Foundation

class IbexHubAPI {
    private let baseUrl: String = "https://ibexhub.ibexmercado.com"
    private let accessToken: String = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjAzMzgxODAsIklEIjoiIiwiVHlwZSI6ImFjY2VzcyIsIlVzZXJJRCI6IjE5ZjUyMDY0LWM4MTUtNDc0Yy1iNGRkLTgwNTUyYzMwYjc4MyIsIlBlcm1pc3Npb25zIjpudWxsLCJQb29sIjoiSUJFWF9IVUIifQ.CsJi_b6OdtIih_-Ne6oDsUBKwnDkSypOOqlrwMVx0EXDHzOwh90s5Q5GKIdQTBjINneDsLPkSBoODFhollgDFuhsiY-nZg4vsPeKhpz7VTk_c8UUWsRdZzpv_Fffs5uvhuTLVYoCoJiYCuSAHp2mby4At92MXiO7LY6z3Rex7sKxITbNk7RC7XueyhxNTxG9e46dPoKXsYtIQWq087c91tsB078fYFieDKWqoJOZfjGYjkOwc1AZ-jKVFy0E1tYcINQ4T5GwXjpToMgLoTeR9k4li20xiv-ZxTFeR5TAPirSHwYmQaLreE0Cm5CkPefAc-ciqn6IjQVGJNmcs3l8GUP8t0d1Dwup7CEtF4_ZNNoxpkvuOyJDjAC7PBQj4CKKfXS7xo8lErOlIwU4XHoL5Ms4U8L5l_UPinEDCtVd5hLbcv4SzRhzOe9z78ABZzxDyyvUV3ThrRrNbVYZ6lWA8dpu7RJtqWX5ZvONjCs1b4Hb2SYMM-zpRtcZfpgCDMiKvhiyMUb77eV1bxWq8gKgum8tmRfNTZGtMt_Po-ql9qBSylgn1cSx1qG4F-srcMGJQ-NfpDeX-6KR_U3V9_AKG5FPDYRUcs-rH13FN-IG50VefdH8smtqQE61OeIWm40nLSepmI3cUT4yXZ5Bg0uDVMUNJLgXzRPo_DE5lW0O52E"
    
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
//
//    func createAccount(name: String)  {
//        guard let url = URL(string: baseUrl + "/account/create") else {
//            return
//        }
//
//        var request = URLRequest(url: url)
//
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let body: [String: AnyHashable] = [
//            "name": name,
//        ]
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
//
//        let task = URLSession.shared.dataTask(with: request) {data, _, error in
//            guard let data = data, error == nil else {
//                print("Error while making request: \(String(describing: error))")
//                return
//            }
//
//            do {
//                let response = try JSONDecoder().decode(IbexAccount.self, from: data)
//                print("Response: \(response)")
//
//                return
//            }
//            catch let error{
//                print("Error while parsing response data: \(error)")
//                return
//            }
//
//        }
//        task.resume()
//
//    }
}
