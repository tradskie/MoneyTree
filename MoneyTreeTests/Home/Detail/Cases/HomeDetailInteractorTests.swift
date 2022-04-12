//
//  HomeDetailInteractorTests.swift
//  MoneyTreeTests
//
//  Created by Jack Xiong Lim on 13/4/22.
//

import XCTest
@testable import MoneyTree

class HomeDetailInteractorTests: XCTestCase {
    var sut: HomeDetailInteractor!
    var mockPresenter: MockHomeDetailPresenter!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        mockPresenter = MockHomeDetailPresenter()
        sut = HomeDetailInteractor(presenter: mockPresenter)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        mockPresenter = nil
        try super.tearDownWithError()
    }
    
    func testHomeDetail_whenTransactionsReturnsResult() {
        // Given
        MockGetTransactionsEvent.type = .someObject
        sut.getTransactionsEventType = MockGetTransactionsEvent.self
        
        // When
        let exp = expectation(for: NSPredicate(block: { (presenter, _) -> Bool in
            return (presenter as! MockHomeDetailPresenter).presentTransactionsWithResponse
        }), evaluatedWith: mockPresenter, handler: nil)
        sut.getTransactions()
        
        // Then
        wait(for: [exp], timeout: 2.0)
        XCTAssertTrue(mockPresenter.presentTransactionsWithResponse)
        
    }
    
    func testHomeDetail_whenTransactionsReturnsError() {
        // Given
        MockGetTransactionsEvent.type = .error
        sut.getTransactionsEventType = MockGetTransactionsEvent.self

        // When
        let exp = expectation(for: NSPredicate(block: { (presenter, _) -> Bool in
            return (presenter as! MockHomeDetailPresenter).presentTransactionsWithError
        }), evaluatedWith: mockPresenter, handler: nil)
        sut.getTransactions()

        // Then
        wait(for: [exp], timeout: 2.0)
        XCTAssertTrue(mockPresenter.presentTransactionsWithError)
    }
    
}
