//
//  HomeDetailInterfaces.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 11/4/22.
//

import Foundation

protocol HomeDetailDisplayable: AnyObject {
    func displayTransactions(with viewModel: HomeDetailModels.TransactionsViewModel)
    func displayTransactions(with error: HomeDetailModels.DataError)
}

protocol HomeDetailBusinessLogic { // Interactor
    func getTransactions()
}

protocol HomeDetailPresentable { // Presenter
    func presentTransactions(with response: HomeDetailModels.TransactionsResponse)
    func presentTransactions(with error: HomeDetailModels.DataError)
}
