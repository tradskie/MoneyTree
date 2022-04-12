//
//  HomeViewControllerTests.swift
//  MoneyTreeTests
//
//  Created by Jack Xiong Lim on 13/4/22.
//

import XCTest
@testable import MoneyTree
import RxSwift

class HomeViewControllerTests: XCTestCase {
    // MARK: - Properties -
    var window: UIWindow!
    var sut: HomeViewController<MockHomeViewModel, MockHomeRouter>!
    var mockRouter: MockHomeRouter!
    var mockViewModel: MockHomeViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        mockViewModel = MockHomeViewModel()
        mockRouter = MockHomeRouter()
        sut = HomeViewController(viewModel: mockViewModel, router: mockRouter)
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        window = nil
        sut = nil
        mockRouter = nil
        mockViewModel = nil
        try super.tearDownWithError()
    }
    
    func testHandleError_whenNotifyErrorCalled() {
        // Given
        let exp = expectation(for: NSPredicate(block: { (mockRouter, _) -> Bool in
            return (mockRouter as! MockHomeRouter).handleError
        }), evaluatedWith: mockRouter, handler: nil)
        
        // When
        sut.viewModel.notifyError.accept(MockGetAccountsEventError.http)
        
        // Then
        wait(for: [exp], timeout: 2.0)
        XCTAssertTrue(mockRouter.handleError)
    }
    
}
