//
//  MockHomeInteractor.swift
//  MoneyTreeTests
//
//  Created by Jack Xiong Lim on 12/4/22.
//

import XCTest
@testable import MoneyTree
import Foundation
import RxSwift

class MockHomeInteractor: HomeBusinessLogic {
    var getAccountsCalled = false
    
    func getAccounts() {
        getAccountsCalled = true
    }
}
