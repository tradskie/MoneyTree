//
//  HomeInteractor.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 7/4/22.
//

import Foundation
import RxSwift

class HomeInteractor: HomeBusinessLogic {
    
    var presenter: HomePresentable?
    var getAccountsEventType: SerialBusEvent.Type = GetAccountsEvent.self
    private var disposeBag = DisposeBag()
    
    init(presenter: HomePresentable) {
        self.presenter = presenter
        EventBus.shared.events(of: getAccountsEventType)
            .subscribe(onNext: { [weak self] (value) in
                guard let strongSelf = self else { return }
                if let payload = value.payload {
                    strongSelf.presenter?.presentAccounts(with: HomeModels.AccountsResponse(response: payload))
                }
                else if let error = value.error {
                    strongSelf.presenter?.presentAccounts(with: HomeModels.DataError(error: error))
                }
            })
            .disposed(by: disposeBag)
        getAccounts()
    }
    
    func getAccounts() {
        EventBus.shared.executeEvent(of: getAccountsEventType)
    }
    
}
