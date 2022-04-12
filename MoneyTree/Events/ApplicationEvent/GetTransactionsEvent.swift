//
//  GetTransactionsEvent.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 11/4/22.
//

import Foundation
import RxSwift

class GetTransactionsEvent: SerialBusEvent<GetTransactionsResponse> {
    // MARK: Overridden Methods
    override class func saga() -> [SerialSubrequest] {
        let subrequest1 = SerialSubrequest(action: { _ in
            return API.getAccountTransactions().map { $0 as Any }
        }, debugInfo: "GET /ef192fdb-7d89-4094-9037-2a7181a0bf46")
        
        return [subrequest1]
    }
}
