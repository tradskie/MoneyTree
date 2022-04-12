//
//  HomePresenterTests.swift
//  MoneyTreeTests
//
//  Created by Jack Xiong Lim on 12/4/22.
//

import XCTest
@testable import MoneyTree

class HomePresenterTests: XCTestCase {
    var sut: HomePresenter!
    var mockViewModel: MockHomeViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        mockViewModel = MockHomeViewModel()
        sut = HomePresenter(viewController: mockViewModel)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        mockViewModel = nil
        try super.tearDownWithError()
    }
    
    func testPresentAccounts_whenReturnsResult() {
        // Given
        let exp = expectation(for: NSPredicate(block: { (mockViewModel, _) -> Bool in
            return (mockViewModel as! MockHomeViewModel).displayAccountsWithViewModel
        }), evaluatedWith: mockViewModel, handler: nil)
        
        // When
        sut.presentAccounts(with: HomeModels.AccountsResponse(response: GetAccountsResponse.mock()))
        
        // Then
        wait(for: [exp], timeout: 2.0)
        XCTAssertTrue(mockViewModel.displayAccountsWithViewModel)
    }
    
    func testPresentAccounts_whenReturnsError() {
        // Given
        let exp = expectation(for: NSPredicate(block: { (mockViewModel, _) -> Bool in
            return (mockViewModel as! MockHomeViewModel).displayAccountsWithError
        }), evaluatedWith: mockViewModel, handler: nil)
        
        // When
        sut.presentAccounts(with: HomeModels.DataError(error: MockGetAccountsEventError.http))
        
        // Then
        wait(for: [exp], timeout: 2.0)
        XCTAssertTrue(mockViewModel.displayAccountsWithError)
    }
    
}
