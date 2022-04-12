//
//  DateFormatter+Extensions.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 11/4/22.
//

import Foundation

extension DateFormatter {
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    static func convert(currentDateInString: String, dateFormat: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
        DateFormatter.formatter.dateFormat = dateFormat
        return DateFormatter.formatter.date(from: currentDateInString)
    }
    
    convenience init(withFormat format: String, locale: String = "en_US_POSIX") {
        self.init()
        
        dateFormat = format
        self.locale = Locale(identifier: locale)
    }
    
}
