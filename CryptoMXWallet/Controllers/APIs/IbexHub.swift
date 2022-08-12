//
//  IbexHub.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 07/08/22.
//

import Foundation

extension APIs.IbexHub {
    
    enum Accounts: RawRepresentable, API {
        
        static var baseUrl: URL = .init(string: "https://ibexhub.ibexmercado.com/account")!

        var rawValue: String {
            switch self {
            case .create: return "create"
            case .details(let id): return "\(id)"
            }
        }
        
        case create
        
        case details(id: String)
        
    }
}
