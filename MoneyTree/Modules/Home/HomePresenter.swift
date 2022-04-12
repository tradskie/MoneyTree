//
//  HomePresenter.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 8/4/22.
//

import Foundation

struct HomePresenter {
    private(set) weak var viewController: HomeDisplayable?
    
    init(viewController: HomeDisplayable) {
        self.viewController = viewController
    }
}

extension HomePresenter: HomePresentable {
    func presentAccounts(with response: HomeModels.AccountsResponse) {
        var viewModels = [HomeTableViewCellViewModel]()
        for (index, account) in response.response.accounts.sorted(by: { $0.institution ?? "" < $1.institution ?? "" }).enumerated() {
            let viewModel = HomeTableViewCellViewModel()
            if index == 0 {
                viewModel.title.accept(account.institution)
            } else {
                viewModel.title.accept(
                    ((account.institution ?? "") == (viewModels.last?.title.value ?? ""))
                    ? nil : account.institution)
            }
            viewModel.id.accept(account.id)
            viewModel.name.accept(account.name)
            viewModel.currency.accept(account.currency)
            viewModel.currentBalance.accept(account.currentBalance)
            viewModels.append(viewModel)
        }
        viewController?.displayAccounts(with: HomeModels.AccountsViewModel(contentVMs: viewModels))
    }
    
    func presentAccounts(with error: HomeModels.DataError) {
        viewController?.displayAccounts(with: error)
    }
    
}
