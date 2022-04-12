//
//  GetTransactionsResponse.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 11/4/22.
//

import Foundation

struct GetTransactionsResponse: Codable {
    let transactions: [TransactionResponse]
}

struct TransactionResponse: Codable {
    let accountId: Int?
    let id: Int?
    let amount: Double?
    let categoryId: Int?
    let date: Date?
    let desc: String?
    
    enum CodingKeys: String, CodingKey {
        case accountId = "account_id", id, amount, categoryId = "category_id", date, desc = "description"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        accountId = try container.decodeIfPresent(Int.self, forKey: .accountId)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        amount = try container.decodeIfPresent(Double.self, forKey: .amount)
        categoryId = try container.decodeIfPresent(Int.self, forKey: .categoryId)
        let dateString = try container.decodeIfPresent(String.self, forKey: .date)
        print("***")
        print(dateString)
        print("***")
        date = DateFormatter.convert(currentDateInString: dateString ?? "")
        desc = try container.decodeIfPresent(String.self, forKey: .desc)
    }
    
}
