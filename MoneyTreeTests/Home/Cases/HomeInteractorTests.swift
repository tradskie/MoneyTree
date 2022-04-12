//
//  HomeInteractorTests.swift
//  MoneyTreeTests
//
//  Created by Jack Xiong Lim on 12/4/22.
//

import XCTest
@testable import MoneyTree

class HomeInteractorTests: XCTestCase {
    var sut: HomeInteractor!
    var mockPresenter: MockHomePresenter!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        mockPresenter = MockHomePresenter()
        sut = HomeInteractor(presenter: mockPresenter)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        mockPresenter = nil
        try super.tearDownWithError()
    }
    
    func testHome_whenAccountsReturnsResult() {
        // Given
        MockGetAccountsEvent.type = .someObject
        sut.getAccountsEventType = MockGetAccountsEvent.self
        
        // When
        let exp = expectation(for: NSPredicate(block: { (presenter, _) -> Bool in
            return (presenter as! MockHomePresenter).presentAccountsWithResponse
        }), evaluatedWith: mockPresenter, handler: nil)
        sut.getAccounts()
        
        // Then
        wait(for: [exp], timeout: 2.0)
        XCTAssertTrue(mockPresenter.presentAccountsWithResponse)
        
    }
    
    func testHome_whenAccountsReturnsError() {
        // Given
        MockGetAccountsEvent.type = .error
        sut.getAccountsEventType = MockGetAccountsEvent.self

        // When
        let exp = expectation(for: NSPredicate(block: { (presenter, _) -> Bool in
            return (presenter as! MockHomePresenter).presentAccountsWithError
        }), evaluatedWith: mockPresenter, handler: nil)
        sut.getAccounts()

        // Then
        wait(for: [exp], timeout: 2.0)
        XCTAssertTrue(mockPresenter.presentAccountsWithError)
    }
}
