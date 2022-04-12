//
//  HomeDetailModels.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 11/4/22.
//

import Foundation

enum HomeDetailModels {
    struct TransactionsResponse {
        let response: GetTransactionsResponse
    }
    
    struct TransactionsViewModel {
        var contentVMs: [HomeTableViewCellViewModel]
    }
    
    struct DataError {
        let error: Error
    }
}
