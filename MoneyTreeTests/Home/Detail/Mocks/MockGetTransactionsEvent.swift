//
//  MockGetTransactionsEvent.swift
//  MoneyTreeTests
//
//  Created by Jack Xiong Lim on 13/4/22.
//

import Foundation
import RxSwift
@testable import MoneyTree

enum MockGetTransactionsEventType {
    case someObject
    case error
}

enum MockGetTransactionsEventError: Error {
    case http
}

class MockGetTransactionsEvent: SerialBusEvent<GetTransactionsResponse> {
    static var type: MockGetTransactionsEventType = .someObject
    
    override class func saga() -> [SerialSubrequest] {
        return [
            SerialSubrequest(action: { (_) -> Single<Any?> in
                switch type {
                case .someObject:
                    return Single.just(GetTransactionsResponse.mock()).map { $0 as Any }
                case .error:
                    return Single.error(MockGetTransactionsEventError.http)
                }
                
            }, debugInfo: "Mocking MockGetTransactionsEvent Event")
        ]
    }
}
