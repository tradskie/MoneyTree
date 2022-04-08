//
//  HomeModels.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 7/4/22.
//

import Foundation

enum HomeModels {
    struct AccountsResponse {
        let response: GetAccountsResponse
    }
    
    struct AccountsViewModel {
        var contentVMs: [HomeTableViewCellViewModel]
    }
    
    struct DataError {
        let error: Error
    }
}
