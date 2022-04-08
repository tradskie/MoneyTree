//
//  SerialSubrequest.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 7/4/22.
//

import Foundation
import RxSwift

struct SerialSubrequest: SubrequestProtocol {
    // The action closure's [Any] parameter first index will be the `parameter` field
    // followed by n number of non-nil responses from the previous subrequests that have come before.
    // This is to allow subsequent requests to retrieve other details from the earlier responses
    // Visually: It should look like this [[Any], response1, response2.., responseN]
    // If this is the first request in the event, then it will only have [[Any]]
    // If it is the second then, it will have [[Any], response1] and so on
    // Because it is possible that a subrequest may have a nullable response, it is not adviced
    // to use an index when traversing through the responses. Instead you should look for a specific
    // object type inside the array to identify the response that you need.
    var action: (([Any]) -> Single<Any?>)
    var parameter: [Any]
    var compensation: Single<Void>?
    var debugInfo: String
    
    init(action: @escaping (([Any]) -> Single<Any?>), parameter: [Any] = [], compensation: Single<Void>? = nil, debugInfo: String) {
        self.action = action
        self.parameter = parameter
        self.compensation = compensation
        self.debugInfo = debugInfo
    }
}
