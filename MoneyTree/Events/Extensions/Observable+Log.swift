//
//  Observable+Log.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 7/4/22.
//

import Foundation
import RxSwift

extension Observable {
    func log(_ event: BusEvent.Type) -> Observable<Element> {
        return self
            .do(onError: { (_) in
                #if DEBUG
                print("[\(Date())]==! Saga `\(String(describing: event))` ABORTED  !==")
                #endif
            }, onCompleted: {
                #if DEBUG
                print("[\(Date())]=== Saga `\(String(describing: event))` COMPLETED ===")
                #endif
            }, onSubscribe: {
                #if DEBUG
                print("[\(Date())]=== Initiate saga `\(String(describing: event))` ===")
                #endif
            })
    }

    func publishPayloadIfApplicable<T>(_ event: T.Type, parameters: Any?, completion: ((T.ReturnType?, Error?) -> Void)? = nil) -> Observable<Element> where T: SerialBusEventProtocol {
        return self
            .do(onNext: { (element) in
                if let element = element as? T.ReturnType {
                    EventBus.shared.publish(T(payload: element, params: parameters))
                    
                    if let completion = completion {
                        completion(element, nil)
                    }
                }
            }, onError: { (error) in
                EventBus.shared.publish(T(error: error, params: parameters))
                
                if let completion = completion {
                    completion(nil, error)
                }
            })
    }
}
