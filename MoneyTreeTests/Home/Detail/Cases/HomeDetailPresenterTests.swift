//
//  HomeDetailPresenterTests.swift
//  MoneyTreeTests
//
//  Created by Jack Xiong Lim on 13/4/22.
//

import XCTest
@testable import MoneyTree

class HomeDetailPresenterTests: XCTestCase {
    var sut: HomeDetailPresenter!
    var mockViewModel: MockHomeDetailViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        mockViewModel = MockHomeDetailViewModel()
        sut = HomeDetailPresenter(viewController: mockViewModel)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        mockViewModel = nil
        try super.tearDownWithError()
    }
    
    func testPresentTransactions_whenReturnsResult() {
        // Given
        let exp = expectation(for: NSPredicate(block: { (mockViewModel, _) -> Bool in
            return (mockViewModel as! MockHomeDetailViewModel).displayTransactionsWithViewModel
        }), evaluatedWith: mockViewModel, handler: nil)
        
        // When
        sut.presentTransactions(with: HomeDetailModels.TransactionsResponse(response: GetTransactionsResponse.mock()))
        
        // Then
        wait(for: [exp], timeout: 2.0)
        XCTAssertTrue(mockViewModel.displayTransactionsWithViewModel)
    }
    
    func testPresentTransactions_whenReturnsError() {
        // Given
        let exp = expectation(for: NSPredicate(block: { (mockViewModel, _) -> Bool in
            return (mockViewModel as! MockHomeDetailViewModel).displayTransactionsWithError
        }), evaluatedWith: mockViewModel, handler: nil)
        
        // When
        sut.presentTransactions(with: HomeDetailModels.DataError(error: MockGetTransactionsEventError.http))
        
        // Then
        wait(for: [exp], timeout: 2.0)
        XCTAssertTrue(mockViewModel.displayTransactionsWithError)
    }
    
}
