//
//  MockHomeRouter.swift
//  MoneyTreeTests
//
//  Created by Jack Xiong Lim on 12/4/22.
//

import UIKit
@testable import MoneyTree

class MockHomeRouter: GeneralRoutable & HomeRoutable {
    var handleError = false
    var navigateToDetail = false
    func navigateBack() {
        
    }
    
    func handleError(error: Error) {
        handleError = true
    }
    
    func navigateToDetail(id: Int, name: String, currency: String) {
        navigateToDetail = true
    }
    
    
}
