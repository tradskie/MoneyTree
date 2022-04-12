//
//  Date+Extensions.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 12/4/22.
//

import Foundation

extension Date {
    func getDateTitle() -> String {
        let calendar = Calendar.current
        DateFormatter.formatter.dateFormat = "MMMM yyyy"
        if (calendar.component(.month, from: Date()) == calendar.component(.month, from: self)) &&
            (calendar.component(.year, from: Date()) == calendar.component(.year, from: self)) {
            return "This Month"
        } else {
            return DateFormatter.formatter.string(from: self)
        }
    }
    
    func getDay() -> String {
        return "\(Calendar.current.component(.day, from: self))"
    }
    
}
