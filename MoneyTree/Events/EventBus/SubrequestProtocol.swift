//
//  SubrequestProtocol.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 7/4/22.
//

import Foundation
import RxSwift

protocol SubrequestProtocol {
    var compensation: Single<Void>? { get }
    var debugInfo: String { get }
}
