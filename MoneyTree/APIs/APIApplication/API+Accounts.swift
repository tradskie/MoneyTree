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
}
