//
//  HomeDetailInteractor.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 11/4/22.
//

import Foundation
import RxSwift

class HomeDetailInteractor: HomeDetailBusinessLogic {
    
    var presenter: HomeDetailPresentable?
    var getTransactionsEventType: SerialBusEvent.Type = GetTransactionsEvent.self
    private var disposeBag = DisposeBag()
    
    init(presenter: HomeDetailPresentable) {
        self.presenter = presenter
        EventBus.shared.events(of: getTransactionsEventType)
            .subscribe(onNext: { [weak self] (value) in
                guard let strongSelf = self else { return }
                if let payload = value.payload {
                    strongSelf.presenter?.presentTransactions(with: HomeDetailModels.TransactionsResponse(response: payload))
                }
                else if let error = value.error {
                    strongSelf.presenter?.presentTransactions(with: HomeDetailModels.DataError(error: error))
                }
            })
            .disposed(by: disposeBag)
        getTransactions()
    }
    
    func getTransactions() {
        EventBus.shared.executeEvent(of: getTransactionsEventType)
    }
    
}
