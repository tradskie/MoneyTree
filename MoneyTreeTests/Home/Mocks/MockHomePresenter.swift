//
//  MockHomePresenter.swift
//  MoneyTreeTests
//
//  Created by Jack Xiong Lim on 12/4/22.
//

import Foundation
@testable import MoneyTree

class MockHomePresenter: HomePresentable {
    
    var presentAccountsWithResponse = false
    var presentAccountsWithError = false
    
    func presentAccounts(with response: HomeModels.AccountsResponse) {
        presentAccountsWithResponse = true
    }
    
    func presentAccounts(with error: HomeModels.DataError) {
        presentAccountsWithError = true
    }
}
