//
//  EventBus.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 7/4/22.
//

import Foundation
import RxSwift
import RxCocoa

struct EventBus {
    // MARK: - Properties -
    // MARK: Public
    static let shared = EventBus()
    private var disposeBag = DisposeBag()
    private static var throttleBin = [BusEvent.Type]()
    
    // MARK: Private
    private var eventsSubject = PublishRelay<BusEvent>()
    
    // MARK: - API -
    // NOTE: All the events will only ever fire the .accept event. The errors should be built into the payload
    
    func events<T>(of type: T.Type) -> Observable<T> where T: SerialBusEventProtocol {
        return eventsSubject
            .filter { $0 is T }
            .map { $0 as! T }
            .do(onSubscribed: {
                if let onSubscribe = type.onSubcribeAction() {
                    onSubscribe
                        .subscribe(onSuccess: { (value) in
                            EventBus.shared.publish(type.init(payload: value, params: nil))
                        })
                        .disposed(by: self.disposeBag)
                }
            })
    }
    
    func events<T>(of type: T.Type) -> Observable<T> where T: ConcurrentBusEventProtocol {
        return eventsSubject
            .filter { $0 is T }
            .map { $0 as! T }
    }
    
    func events<T, U>(of type: T.Type, triggering single: Single<U>? = nil) -> Single<T> where T: StandaloneEventProtocol, T.ReturnType == U {
        defer {
            if let single = single {
                execute(single, toTrigger: type)
            }
        }
        return eventsSubject
            .filter { $0 is T }
            .map { $0 as! T }
            .take(1)
            .asSingle()
    }
    
    func publish(_ event: BusEvent) {
        eventsSubject.accept(event)
    }
    
    func executeEvent<T>(of type: T.Type, parameters: Any? = nil, completion: ((T.ReturnType?, Error?) -> Void)? = nil) where T: SerialBusEventProtocol {
        // Note: Throttling only applies to pub sub model. The completion block doesn't currently have a way to detect when there is an active pub sub running.
        guard !(completion == nil && T.throttle && (EventBus.throttleBin.contains { $0 == type })) else { return }
        EventBus.throttleBin.append(type)
        
        chainRequest(eventType: type, parameters: parameters, serialSubrequests: type.saga(), completion: completion)
            .log(type)
            .do(afterError: { _ in
                EventBus.throttleBin.removeAll { $0 == type }
            }, afterCompleted: {
                EventBus.throttleBin.removeAll { $0 == type }
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    func executeEvent<T>(of type: T.Type, parameters: [Any] = []) where T: ConcurrentBusEventProtocol {
        guard !(T.throttle && (EventBus.throttleBin.contains { $0 == type })) else { return }
        
        EventBus.throttleBin.append(type)
        
        Observable.from(type.saga(parameters))
            .map({ (subrequest) in
                return subrequest.action
                    .log(subrequest)
            })
            .merge()
            .log(type)
            .do(afterError: { _ in
                EventBus.throttleBin.removeAll { $0 == type }
            }, afterCompleted: {
                EventBus.throttleBin.removeAll { $0 == type }
            })
            .subscribe(onNext: { obj in
                if let obj = obj as? T.ReturnType {
                    self.publish(T(payload: obj))
                }
            }, onError: { error in
                let event = T(error: error, params: parameters)
                self.publish(event)
            })
            .disposed(by: disposeBag)
    }
    
    func execute<T, U>(_ single: Single<U>, toTrigger: T.Type) where T: StandaloneEventProtocol, T.ReturnType == U {
        guard !(T.throttle && (EventBus.throttleBin.contains { $0 == toTrigger })) else { return }
        
        EventBus.throttleBin.append(toTrigger)
        
        single
            .do(afterSuccess: { _ in
                EventBus.throttleBin.removeAll { $0 == toTrigger }
            }, afterError: { _ in
                EventBus.throttleBin.removeAll { $0 == toTrigger }
            })
            .subscribe(onSuccess: { (payload) in
                let event = T(payload: payload)
                self.publish(event)
            }, onFailure: { (error) in
                let event = T(error: error, params: nil)
                self.publish(event)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private API -
    // MARK: Utility Methods
    
    private func chainRequest<T>(eventType: T.Type, parameters: Any?, serialSubrequests: [SerialSubrequest], previousAction: Single<Any?>? = nil, completion: ((T.ReturnType?, Error?) -> Void)? = nil) -> Single<Any?> where T: SerialBusEventProtocol {
        var remainingSubrequests = serialSubrequests
        
        if remainingSubrequests.count == 0 {
            if let previousAction = previousAction {
                return previousAction
            }
            else {
                return Single.never()
            }
        }
        else {
            let currentSubrequest = remainingSubrequests.removeFirst()
            
            var params: [Any] = parameters != nil ? [parameters!] : []
            if let previousAction = previousAction {
                return chainRequest(eventType: eventType,
                                    parameters: parameters,
                                    serialSubrequests: remainingSubrequests,
                                    previousAction: previousAction.flatMap({ (result) in
                                        if let result = result {
                                            params.append(result)
                                        }
                                        return self.currentAction(eventType: eventType, currentSubrequest: currentSubrequest, parameters: params, completion: completion)
                                    }),
                                    completion: completion)
            }
            else {
                return chainRequest(eventType: eventType,
                                    parameters: parameters,
                                    serialSubrequests: remainingSubrequests,
                                    previousAction: currentAction(eventType: eventType, currentSubrequest: currentSubrequest, parameters: params, completion: completion),
                                    completion: completion)
            }
        }
    }
    
    private func currentAction<T>(eventType: T.Type, currentSubrequest: SerialSubrequest, parameters: [Any], completion: ((T.ReturnType?, Error?) -> Void)? = nil) -> Single<Any?> where T: SerialBusEventProtocol {
        return currentSubrequest.action(parameters)
            .log(currentSubrequest)
            .publishPayloadIfApplicable(eventType, parameters: parameters.first, completion: completion)
            .take(1)
            .asSingle()
    }
}
