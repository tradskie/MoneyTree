//
//  SerialBusEvent.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 7/4/22.
//

import Foundation
import RxSwift

open class SerialBusEvent<PayloadType>: SerialBusEventProtocol {
    private(set) var payload: PayloadType?
    private(set) var error: Error?
    private(set) var params: Any?
    
    open class var throttle: Bool {
        return false
    }
    
    open class func onSubcribeAction() -> Single<PayloadType>? {
        return nil
    }
    
    class func saga() -> [SerialSubrequest] {
        return []
    }
    
    required public init(payload: PayloadType, params: Any? = nil) {
        self.payload = payload
        self.params = params
    }
    
    required public init(error: Error, params: Any? = nil) {
        self.error = error
        self.params = params
    }
}

open class RetrievalSerialBusEvent<PayloadType>: SerialBusEvent<PayloadType> {
    enum SetupError: Error {
        case cacheRetrievalNotOverridden
        case serverRetrievalNotOverridden
        case mergedRetrievalNotOverridden
    }
    final override class func saga() -> [SerialSubrequest] {
        let cacheRetrievalSubrequest = SerialSubrequest(action: { (parameters) in
            return cacheRetrieval(parameters: parameters).map { $0 as Any }
        }, debugInfo: "Retrieve from cache for `\(String(describing: self))`")
        let serverRetrievalSubrequest = SerialSubrequest(action: { (parameters) in
            return serverRetrieval(parameters: parameters).map { $0 as Any }
        }, debugInfo: "Retrieve from cache for `\(String(describing: self))`")
        let mergedRetrievalSubrequest = SerialSubrequest(action: { (parameters) in
            return mergedRetrieval(parameters: parameters).map { $0 as Any }
        }, debugInfo: "Retrieve from cache for `\(String(describing: self))`")
        
        return [
            cacheRetrievalSubrequest,
            serverRetrievalSubrequest,
            mergedRetrievalSubrequest
        ]
    }
    
    open class func cacheRetrieval(parameters: [Any] = []) -> Single<PayloadType> {
        return Single.error(SetupError.cacheRetrievalNotOverridden)
    }
    
    open class func serverRetrieval(parameters: [Any] = []) -> Single<PayloadType> {
        return Single.error(SetupError.serverRetrievalNotOverridden)
    }
    
    open class func mergedRetrieval(parameters: [Any] = []) -> Single<PayloadType> {
        return Single.error(SetupError.mergedRetrievalNotOverridden)
    }
}

open class SingleSerialBusEvent<PayloadType>: SerialBusEvent<PayloadType> {
    final override class func saga() -> [SerialSubrequest] {
        let subrequest = SerialSubrequest(action: { (parameters) in
            return single(parameters: parameters).map { $0 as Any }
        }, debugInfo: "Executing single in `\(String(describing: self))`")
        
        return [subrequest]
    }
    
    open class func single(parameters: [Any] = []) -> Single<PayloadType> {
        return Single.never()
    }
}
