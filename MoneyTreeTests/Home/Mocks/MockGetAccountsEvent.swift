//
//  MockGetAccountsEvent.swift
//  MoneyTreeTests
//
//  Created by Jack Xiong Lim on 12/4/22.
//

import Foundation
import RxSwift
@testable import MoneyTree

enum MockGetAccountsEventType {
    case someObject
    case error
}

enum MockGetAccountsEventError: Error {
    case http
}

class MockGetAccountsEvent: SerialBusEvent<GetAccountsResponse> {
    static var type: MockGetAccountsEventType = .someObject
    
    override class func saga() -> [SerialSubrequest] {
        return [
            SerialSubrequest(action: { (_) -> Single<Any?> in
                switch type {
                case .someObject:
                    return Single.just(GetAccountsResponse.mock()).map { $0 as Any }
                case .error:
                    return Single.error(MockGetAccountsEventError.http)
                }
                
            }, debugInfo: "Mocking GetAccountsEvent Event")
        ]
    }
}
