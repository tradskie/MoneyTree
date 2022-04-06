//
//  ValueCell.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 5/4/22.
//

import Foundation

protocol ValueCell: AnyObject {
    associatedtype Value
    static var defaultReusableId: String { get }
    func configureWith(value: Value)
}

extension ValueCell {
    static var defaultReusableId: String {
        return String(describing: self)
    }
}
