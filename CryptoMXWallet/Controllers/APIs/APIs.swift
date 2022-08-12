//
//  LNController.swift
//  CryptoMXWallet
//
//  Created by Osvaldo Rosales Perez on 06/08/22.
//

import Foundation

enum APIs {
    
    enum IbexHub {}
    
    enum IbexPay: API {
        static let baseUrl = URL(string: "https://ibexpay.ibexmercado.com")!
    }
}

protocol API {
    
    static var baseUrl: URL { get }
    
}

extension RawRepresentable where RawValue == String, Self: API {
    
    var url: URL { Self.baseUrl.appendingPathComponent(rawValue)}
    
    init?(rawValue: String){ nil }
}
