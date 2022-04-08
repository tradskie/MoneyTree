//
//  APISuperClass.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 8/4/22.
//

import Foundation

enum HTTPRequestError: Error {
    case unauthorizedAccess
    case invalidURL
    case dataNotFound
}

class APISuperClass {
    
    // MARK: - Properties -
    public static var baseUrl: String {
        return "https://run.mocky.io/v3/"
    }
}
