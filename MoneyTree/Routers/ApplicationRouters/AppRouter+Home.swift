//
//  AppRouter+Home.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 5/4/22.
//

import Foundation

extension AppRouterGeneral: HomeRoutable {
    func navigateToDetail(id: Int, name: String, currency: String) {
        // TODO: - hardcoded currency for demo purpose - due to accountID 2 is JPY
        let viewController = HomeDetailViewController(viewModel: HomeDetailViewModel(id: id, name: name, currency: "JPY"), router: AppRouterGeneral.sharedInstance())
        navigateTo(viewController)
    }
}
