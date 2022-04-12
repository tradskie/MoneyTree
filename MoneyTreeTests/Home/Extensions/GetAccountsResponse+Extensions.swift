//
//  GetAccountsResponse+Extensions.swift
//  MoneyTreeTests
//
//  Created by Jack Xiong Lim on 12/4/22.
//

import Foundation
@testable import MoneyTree

extension GetAccountsResponse {
    static func mock() -> Self {
        let decoder = JSONDecoder()
        let json = """
            {
              "accounts": [
                {
                  "id": 1,
                  "name": "外貨普通(USD)",
                  "institution": "Test Bank",
                  "currency": "USD",
                  "current_balance": 22.5,
                  "current_balance_in_base": 2306.0
                },
                {
                  "id": 2,
                  "name": "マークからカード",
                  "institution": "Starbucks Card",
                  "currency": "JPY",
                  "current_balance": 3035.0,
                  "current_balance_in_base": 3035.0

                },
                {
                  "id": 3,
                  "name": "マイカード",
                  "institution": "Starbucks Card",
                  "currency": "JPY",
                  "current_balance": 0.0,
                  "current_balance_in_base": 0.0
                }
              ]
            }
            """.data(using: .utf8)!
        return try! decoder.decode(GetAccountsResponse.self, from: json)
    }
}
