//
//  HomeDetailViewModelTests.swift
//  MoneyTreeTests
//
//  Created by Jack Xiong Lim on 13/4/22.
//

import XCTest
@testable import MoneyTree
import RxSwift

class HomeDetailViewModelTests: XCTestCase {
    var sut: HomeDetailViewModel!
    var viewController: HomeDetailViewController<HomeDetailViewModel, MockHomeRouter>!
    var mockInteractor: MockHomeDetailInteractor!
    var mockRouter: MockHomeRouter!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = HomeDetailViewModel(id: 2, name: "マークからカード", currency: "JPY")
        mockInteractor = MockHomeDetailInteractor()
        sut.interactor = mockInteractor
        loadViewController()
    }
    
    private func loadViewController() {
        mockRouter = MockHomeRouter()
        viewController = HomeDetailViewController(viewModel: sut, router: mockRouter)
        viewController.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        viewController = nil
        mockInteractor = nil
        mockRouter = nil
        try super.tearDownWithError()
    }
    
    func testHome_whenDisplayAccountsWithResponse_getCalled() {
        // When
        sut.displayTransactions(with: HomeDetailModels.TransactionsViewModel.mock())
        
        // Then
        XCTAssertNotNil(sut.transactions.value)
    }
    
    func testNotifyError_whenDisplayAccountsWithError_getCalled() {
        // Given
        let exp = givenViewIsLoadedAndNotifyErrorExpectation()
        
        // When
        sut.displayTransactions(with: HomeDetailModels.DataError(error: MockGetTransactionsEventError.http))
        
        // Then
        wait(for: [exp], timeout: 2.0)
    }
    
    private func givenViewIsLoadedAndNotifyErrorExpectation() -> XCTestExpectation {
        return expectation(for: NSPredicate(block: { (mockRouter, _) -> Bool in
            return (mockRouter as! MockHomeRouter).handleError
        }), evaluatedWith: mockRouter, handler: nil)
    }
    
}
