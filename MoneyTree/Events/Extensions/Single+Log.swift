//
//  Single+Log.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 7/4/22.
//

import Foundation
import RxSwift

extension Single {
    func log(_ subrequest: SubrequestProtocol) -> Observable<Element> {
        var request = subrequest
        
        return self
            .asObservable()
            .do(onNext: { _ in
                #if DEBUG
                let date = Date()
                withUnsafePointer(to: &request) {
                    print("[\(date)]*** Subrequest `\(subrequest.debugInfo)`(\($0)) completed")
                }
                #endif
            }, onError: { error in
                #if DEBUG
                let date = Date()
                withUnsafePointer(to: &request) {
                    print("[\(date)]** Subrequest `\(subrequest.debugInfo)`(\($0)) failed **\n\(error.localizedDescription)\n")
                }
                #endif
            }, onSubscribe: {
                #if DEBUG
                let date = Date()
                withUnsafePointer(to: &request) {
                    print("[\(date)]*** Subrequest `\(subrequest.debugInfo)`(\($0)) started")
                }
                #endif
            })
    }
    
    func log(_ event: BusEvent.Type) -> Observable<Element> {
        return self
            .asObservable()
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
}
