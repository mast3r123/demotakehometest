//
//  Date+Extension.swift
//  GitSample
//
//  Created by master on 5/15/22.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.month(.wide).year(.defaultDigits))
    }
    
}
