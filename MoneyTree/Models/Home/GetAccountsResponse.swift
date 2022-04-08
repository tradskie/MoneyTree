//
//  GetAccountsResponse.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 7/4/22.
//

import Foundation

struct GetAccountsResponse: Codable {
    let accounts: [AccountResponse]
}

struct AccountResponse: Codable {
    let id: Int?
    let name: String?
    let institution: String?
    let currency: String?
    let currentBalance: Double?
    let currentBalanceInBase: Double?
    
    enum CodingKeys: String, CodingKey {
      case id, name, institution, currency, currentBalance = "current_balance", currentBalanceInBase = "current_balance_in_base"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        institution = try container.decodeIfPresent(String.self, forKey: .institution)
        currency = try container.decodeIfPresent(String.self, forKey: .currency)
        currentBalance = try container.decodeIfPresent(Double.self, forKey: .currentBalance)
        currentBalanceInBase = try container.decodeIfPresent(Double.self, forKey: .currentBalanceInBase)
    }
    
}
