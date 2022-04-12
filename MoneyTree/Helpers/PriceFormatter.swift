//
//  PriceFormatter.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 11/4/22.
//

import Foundation
public struct PriceFormatter {
    static let defaultFormatter: NumberFormatter = {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currencyISOCode
        formatter.currencyCode = "JPY"
        return formatter
    }()
    
    static func format(amount: Double ,
                       currencyCode: String = "JPY") -> String? {
        let formatter: NumberFormatter = defaultFormatter.copy() as! NumberFormatter
        let amountNumber = NSDecimalNumber.init(value: amount)
        formatter.currencyCode = currencyCode
        formatter.currencySymbol = nil
        return formatter.string(from: amountNumber)
    }
}
