//
//  HomeDetailViewModel+Extensions.swift
//  MoneyTreeTests
//
//  Created by Jack Xiong Lim on 13/4/22.
//

import Foundation
@testable import MoneyTree

extension HomeDetailModels.TransactionsViewModel {
    static func mock() -> Self {
        let value = GetTransactionsResponse.mock()
        var viewModels = [HomeTableViewCellViewModel]()
        for transaction in value.transactions {
            let viewModel = HomeTableViewCellViewModel()
            viewModel.title.accept("\(transaction.date ?? Date())")
            viewModel.id.accept(transaction.id)
            viewModel.name.accept(transaction.desc)
            viewModel.currency.accept("JPY")
            viewModel.currentBalance.accept(transaction.amount)
            viewModels.append(viewModel)
        }
        return HomeDetailModels.TransactionsViewModel(contentVMs: viewModels)
    }
}
