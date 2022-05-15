//
//  Date+Extension.swift
//  GitSample
//
//  Created by master on 5/15/22.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
}
