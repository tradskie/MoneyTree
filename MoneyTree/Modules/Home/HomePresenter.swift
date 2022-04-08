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
        for account in response.response.accounts {
            print(account.name)
        }
    }
    
    func presentAccounts(with error: HomeModels.DataError) {
        print("presentAccounts(with error")
    }
    
}
