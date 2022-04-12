//
//  MockHomeViewModel.swift
//  MoneyTreeTests
//
//  Created by Jack Xiong Lim on 12/4/22.
//

import XCTest
@testable import MoneyTree
import RxCocoa
import RxDataSources

class MockHomeViewModel: HomeViewModelType {
    
    var accounts: BehaviorRelay<[HomeTableViewCellViewModel]> = BehaviorRelay(value: [])
    var notifyError: PublishRelay<Error?> = PublishRelay()
    
    var sectionedItems: BehaviorRelay<[HomeSection]> = BehaviorRelay(value: [])
    
    var sectionCache: [Int : HomeSection] = [Int: HomeSection]()
    
    var dataSource: RxTableViewSectionedReloadDataSource<HomeSection> = Section.generateDataSource()
    
    var displayAccountsWithViewModel = false
    var displayAccountsWithError = false
    
    required init() {}
}

extension MockHomeViewModel: HomeDisplayable {
    func displayAccounts(with viewModel: HomeModels.AccountsViewModel) {
        displayAccountsWithViewModel = true
    }
    
    func displayAccounts(with error: HomeModels.DataError) {
        displayAccountsWithError = true
    }
}
