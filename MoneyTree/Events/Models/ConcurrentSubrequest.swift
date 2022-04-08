//
//  ConcurrentSubrequest.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 7/4/22.
//

import Foundation
import RxSwift

struct ConcurrentSubrequest: SubrequestProtocol {
    public var action: Single<Any?>
    public var compensation: Single<Void>?
    public var debugInfo: String
    
    public init(action: Single<Any?>, compensation: Single<Void>? = nil, debugInfo: String) {
        self.action = action
        self.compensation = compensation
        self.debugInfo = debugInfo
    }
}
