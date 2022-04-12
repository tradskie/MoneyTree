//
//  HomeViewModel+Extensions.swift
//  MoneyTreeTests
//
//  Created by Jack Xiong Lim on 12/4/22.
//

import Foundation
@testable import MoneyTree

extension HomeModels.AccountsViewModel {
    static func mock() -> Self {
        let value = GetAccountsResponse.mock()
        var viewModels = [HomeTableViewCellViewModel]()
        for account in value.accounts {
            let viewModel = HomeTableViewCellViewModel()
            viewModel.title.accept(account.institution)
            viewModel.id.accept(account.id)
            viewModel.name.accept(account.name)
            viewModel.currency.accept(account.currency)
            viewModel.currentBalance.accept(account.currentBalance)
            viewModels.append(viewModel)
        }
        return HomeModels.AccountsViewModel(contentVMs: viewModels)
    }
}
