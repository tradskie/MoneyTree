//
//  HomeViewModelTests.swift
//  MoneyTreeTests
//
//  Created by Jack Xiong Lim on 12/4/22.
//

import XCTest
@testable import MoneyTree
import RxSwift

class HomeViewModelTests: XCTestCase {
    var sut: HomeViewModel!
    var viewController: HomeViewController<HomeViewModel, MockHomeRouter>!
    var mockInteractor: MockHomeInteractor!
    var mockRouter: MockHomeRouter!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = HomeViewModel()
        mockInteractor = MockHomeInteractor()
        sut.interactor = mockInteractor
        loadViewController()
    }
    
    private func loadViewController() {
        mockRouter = MockHomeRouter()
        viewController = HomeViewController(viewModel: sut, router: mockRouter)
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
        sut.displayAccounts(with: HomeModels.AccountsViewModel.mock())
        
        // Then
        XCTAssertNotNil(sut.accounts.value)
    }
    
    func testNotifyError_whenDisplayAccountsWithError_getCalled() {
        // Given
        let exp = givenViewIsLoadedAndNotifyErrorExpectation()
        
        // When
        sut.displayAccounts(with: HomeModels.DataError(error: MockGetAccountsEventError.http))
        
        // Then
        wait(for: [exp], timeout: 2.0)
    }
    
    private func givenViewIsLoadedAndNotifyErrorExpectation() -> XCTestExpectation {
        return expectation(for: NSPredicate(block: { (mockRouter, _) -> Bool in
            return (mockRouter as! MockHomeRouter).handleError
        }), evaluatedWith: mockRouter, handler: nil)
    }
    
}
