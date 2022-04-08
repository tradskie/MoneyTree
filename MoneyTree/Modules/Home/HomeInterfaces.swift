//
//  HomeInterfaces.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 7/4/22.
//

import Foundation

protocol HomeDisplayable: AnyObject {
    func displayAccounts(with viewModel: HomeModels.AccountsViewModel)
    func displayAccounts(with error: HomeModels.DataError)
}

protocol HomeBusinessLogic { // Interactor
    func getAccounts()
}

protocol HomePresentable { // Presenter
    func presentAccounts(with response: HomeModels.AccountsResponse)
    func presentAccounts(with error: HomeModels.DataError)
}
