//
//  GetTransactionsResponse+Extensions.swift
//  MoneyTreeTests
//
//  Created by Jack Xiong Lim on 13/4/22.
//

import Foundation
@testable import MoneyTree

extension GetTransactionsResponse {
    static func mock() -> Self {
        let decoder = JSONDecoder()
        let json = """
        {
          "transactions": [
            {
              "account_id": 2,
              "amount": -442.0,
              "category_id": 112,
              "date": "2017-05-26T00:00:00+09:00",
              "description": "Lorem",
              "id": 21
            },
            {
              "account_id": 2,
              "amount": -442.0,
              "category_id": 112,
              "date": "2017-05-24T00:00:00+09:00",
              "description": "Ipsum",
              "id": 22
            },
            {
              "account_id": 2,
              "amount": -421.0,
              "category_id": 112,
              "date": "2017-05-23T00:00:00+09:00",
              "description": "hehe",
              "id": 23
            },
            {
              "account_id": 2,
              "amount": 5000.0,
              "category_id": 112,
              "date": "2017-04-19T00:00:00+09:00",
              "description": "haha",
              "id": 24
            },
            {
              "account_id": 2,
              "amount": -1047.0,
              "category_id": 112,
              "date": "2017-04-19T00:00:00+09:00",
              "description": "hoho",
              "id": 25
            }
          ]
        }
        """.data(using: .utf8)!
        return try! decoder.decode(GetTransactionsResponse.self, from: json)
    }
}
