//
//  DateExt.swift
//  GitWood
//
//  Created by Nour on 23/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import Foundation

extension Date {
    func periodDateFor(_ period: RequestPeriod, specifiedDate:Date =  Date()) -> String {
        
        let dateFromatter = DateFormatter()
        dateFromatter.dateFormat = "yyyy-MM-dd"
        var date: Date? = nil
        
        switch period {
        case .LastDay:
            date = Calendar.current.date(byAdding: .day, value: -1, to: specifiedDate)
        case .LastWeek:
            date = Calendar.current.date(byAdding: .day, value: -7, to: specifiedDate)
        case .LastMonth:
            date = Calendar.current.date(byAdding: .month, value: -1, to: specifiedDate)
        }
        
        return dateFromatter.string(from: date!)
    }
}
