//
//  API+Accounts.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 7/4/22.
//

import Foundation
import RxSwift

extension API {
    static func getAccounts() -> Single<GetAccountsResponse> {
        return API.request(.get, "\(baseUrl)d18b3988-58a7-4977-aecd-77f58c272f8a")
    }
    static func getAccountTransactions() -> Single<GetTransactionsResponse> {
        return API.request(.get, "\(baseUrl)ef192fdb-7d89-4094-9037-2a7181a0bf46")
    }
}
