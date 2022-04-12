//
//  HomeDetailViewModel.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 11/4/22.
//

import Foundation
import RxCocoa
import RxDataSources

protocol HomeDetailViewModelType: SectionSetter, TableViewSectionSetter where Section == HomeDetailSection {
    var transactions: BehaviorRelay<[HomeTableViewCellViewModel]> { get }
    var id: BehaviorRelay<Int?> { get }
    var name: BehaviorRelay<String?> { get }
    var currency: BehaviorRelay<String?> { get }
    var notifyError: PublishRelay<Error?> { get }
    init()
}

class HomeDetailViewModel: HomeDetailViewModelType {
    let transactions: BehaviorRelay<[HomeTableViewCellViewModel]> = BehaviorRelay(value: [])
    var id = BehaviorRelay<Int?>(value: nil)
    var name = BehaviorRelay<String?>(value: nil)
    var currency = BehaviorRelay<String?>(value: nil)
    var notifyError: PublishRelay<Error?> = PublishRelay()
    var dataSource: RxTableViewSectionedReloadDataSource<Section> = Section.generateDataSource()
    var sectionedItems: BehaviorRelay<[HomeDetailSection]> = BehaviorRelay(value: [])
    var sectionCache = [Int: HomeDetailSection]()
    
    var interactor: HomeDetailBusinessLogic!
    
    required init() {
        interactor = HomeDetailInteractor(presenter: HomeDetailPresenter(viewController: self))
    }
    
    convenience init(id: Int, name: String, currency: String) {
        self.init()
        self.id.accept(id)
        self.name.accept(name)
        self.currency.accept(currency)
    }
    
}

extension HomeDetailViewModel: HomeDetailDisplayable {
    func displayTransactions(with viewModel: HomeDetailModels.TransactionsViewModel) {
        for vm in viewModel.contentVMs {
            vm.currency.accept(currency.value)
        }
        
        transactions.accept(viewModel.contentVMs)
    }
    
    func displayTransactions(with error: HomeDetailModels.DataError) {
        notifyError.accept(error.error)
    }
}
