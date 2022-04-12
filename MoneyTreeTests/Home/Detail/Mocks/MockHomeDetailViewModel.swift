//
//  MockHomeDetailViewModel.swift
//  MoneyTreeTests
//
//  Created by Jack Xiong Lim on 13/4/22.
//

import XCTest
@testable import MoneyTree
import RxCocoa
import RxDataSources

class MockHomeDetailViewModel: HomeDetailViewModelType {
    var transactions: BehaviorRelay<[HomeTableViewCellViewModel]> = BehaviorRelay(value: [])
    var notifyError: PublishRelay<Error?> = PublishRelay()
    
    var id: BehaviorRelay<Int?> = BehaviorRelay(value: nil)
    
    var name: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    var currency: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    var sectionedItems: BehaviorRelay<[HomeDetailSection]> = BehaviorRelay(value: [])
    
    var sectionCache: [Int : HomeDetailSection] = [Int: HomeDetailSection]()
    
    var dataSource: RxTableViewSectionedReloadDataSource<HomeDetailSection> = Section.generateDataSource()
    
    var displayTransactionsWithViewModel = false
    var displayTransactionsWithError = false
    
    required init() {}
}

extension MockHomeDetailViewModel: HomeDetailDisplayable {
    func displayTransactions(with viewModel: HomeDetailModels.TransactionsViewModel) {
        displayTransactionsWithViewModel = true
    }
    
    func displayTransactions(with error: HomeDetailModels.DataError) {
        displayTransactionsWithError = true
    }
    
    
}
