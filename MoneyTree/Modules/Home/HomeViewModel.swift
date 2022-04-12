//
//  HomeViewModel.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 5/4/22.
//

import Foundation
import RxCocoa
import RxDataSources

protocol HomeViewModelType: SectionSetter, TableViewSectionSetter where Section == HomeSection {
    var accounts: BehaviorRelay<[HomeTableViewCellViewModel]> { get }
    var notifyError: PublishRelay<Error?> { get }
    init()
}

class HomeViewModel: HomeViewModelType {
    
    let accounts: BehaviorRelay<[HomeTableViewCellViewModel]> = BehaviorRelay(value: [])
    let notifyError: PublishRelay<Error?> = PublishRelay()
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section> = Section.generateDataSource()
    var sectionedItems: BehaviorRelay<[HomeSection]> = BehaviorRelay(value: [])
    var sectionCache = [Int: HomeSection]()
    
    var interactor: HomeBusinessLogic!
    
    required init() {
        interactor = HomeInteractor(presenter: HomePresenter(viewController: self))
    }
}

extension HomeViewModel: HomeDisplayable {
    func displayAccounts(with viewModel: HomeModels.AccountsViewModel) {
        accounts.accept(viewModel.contentVMs)
    }
    
    func displayAccounts(with error: HomeModels.DataError) {
        notifyError.accept(error.error)
    }
    
    
}
