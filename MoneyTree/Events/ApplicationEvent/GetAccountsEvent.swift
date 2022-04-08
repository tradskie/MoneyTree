//
//  GetAccountsEvent.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 7/4/22.
//

import Foundation
import RxSwift

class GetAccountsEvent: SerialBusEvent<GetAccountsResponse> {
    // MARK: Overridden Methods
    override class func saga() -> [SerialSubrequest] {
        let subrequest1 = SerialSubrequest(action: { _ in
            return API.getAccounts().map { $0 as Any }
        }, debugInfo: "GET /d18b3988-58a7-4977-aecd-77f58c272f8a")
        
        return [subrequest1]
    }
}
