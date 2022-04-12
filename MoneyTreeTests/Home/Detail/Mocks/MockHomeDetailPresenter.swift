//
//  MockHomeDetailPresenter.swift
//  MoneyTreeTests
//
//  Created by Jack Xiong Lim on 13/4/22.
//

import Foundation
@testable import MoneyTree

class MockHomeDetailPresenter: HomeDetailPresentable {
    
    var presentTransactionsWithResponse = false
    var presentTransactionsWithError = false
    
    func presentTransactions(with response: HomeDetailModels.TransactionsResponse) {
        presentTransactionsWithResponse = true
    }
    
    func presentTransactions(with error: HomeDetailModels.DataError) {
        presentTransactionsWithError = true
    }
}
