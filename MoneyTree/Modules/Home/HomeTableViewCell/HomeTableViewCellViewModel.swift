//
//  HomeTableViewCellViewModel.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 6/4/22.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeTableViewCellViewModelType {
    var id: BehaviorRelay<Int?> { get }
    var title: BehaviorRelay<String?> { get }
    var name: BehaviorRelay<String?> { get }
    var currency: BehaviorRelay<String?> { get }
    var currentBalance: BehaviorRelay<Double?> { get }
}

class HomeTableViewCellViewModel: HomeTableViewCellViewModelType {
    var id = BehaviorRelay<Int?>(value: nil)
    var title = BehaviorRelay<String?>(value: nil)
    var name = BehaviorRelay<String?>(value: nil)
    var currency = BehaviorRelay<String?>(value: nil)
    var currentBalance = BehaviorRelay<Double?>(value: nil)
}
