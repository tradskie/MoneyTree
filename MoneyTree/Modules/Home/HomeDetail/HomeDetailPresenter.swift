//
//  HomeDetailPresenter.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 11/4/22.
//

import Foundation

struct HomeDetailPresenter {
    private(set) weak var viewController: HomeDetailDisplayable?
    
    init(viewController: HomeDetailDisplayable) {
        self.viewController = viewController
    }
}

extension HomeDetailPresenter: HomeDetailPresentable {
    func presentTransactions(with response: HomeDetailModels.TransactionsResponse) {
        var viewModels = [HomeTableViewCellViewModel]()
        for (index, transaction) in response.response.transactions.sorted(by: { $0.date ?? Date() > $1.date ?? Date() }).enumerated() {
            let viewModel = HomeTableViewCellViewModel()
            if let date = transaction.date {
                if index == 0 {
                    viewModel.title.accept(date.getDateTitle())
                } else {
                    let previousVM = viewModels.last { $0.title.value != nil }
                    viewModel.title.accept(date.getDateTitle() == previousVM?.title.value! ? nil : date.getDateTitle())
                }
                viewModel.name.accept("\(date.getDay())  \(transaction.desc ?? "")")
            }
            viewModel.id.accept(transaction.id)
            viewModel.currentBalance.accept(transaction.amount)
            viewModels.append(viewModel)
        }
        viewController?.displayTransactions(with: HomeDetailModels.TransactionsViewModel(contentVMs: viewModels))
    }
    
    func presentTransactions(with error: HomeDetailModels.DataError) {
        print("presentTransactions(with error")
    }
    
    
}
