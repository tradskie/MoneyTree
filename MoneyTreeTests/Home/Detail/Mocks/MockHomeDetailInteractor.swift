//
//  MockHomeDetailInteractor.swift
//  MoneyTreeTests
//
//  Created by Jack Xiong Lim on 13/4/22.
//

import XCTest
@testable import MoneyTree
import Foundation
import RxSwift

class MockHomeDetailInteractor: HomeDetailBusinessLogic {
    var getTransactionsCalled = false
    
    func getTransactions() {
        getTransactionsCalled = true
    }
}
