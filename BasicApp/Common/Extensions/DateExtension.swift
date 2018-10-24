//
//  DateExtension.swift
//  
//
//  Created by Finoit Technologies, Inc. 
//  Copyright  Finoit Technologies, Inc.. All rights reserved.
//

import UIKit

extension Date {
    
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
    var isToday: Bool {
        return self.isEqualToDateIgnoringTime(date: Date())
    }
    
    var isTomorrow: Bool {
        return self.isEqualToDateIgnoringTime(date: Date().tomorrow)
    }
    
    var isYesterday: Bool {
        return self.isEqualToDateIgnoringTime(date: Date().yesterday)
    }
    
    var weekDaySymbol: String {
        let weekDays = ["Su", "M", "T", "W", "Th", "F", "S"]
        let weekDay = Calendar.current.component(.weekday, from: self) - 1
        return weekDays[weekDay]
    }
    
    var UTCOnlyDate: Date {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        var components = calendar.dateComponents([.year, .month, .day], from: self)
        components.hour = 0
        components.minute = 0
        components.second = 0
        return calendar.date(from: components)!
    }
    
    var dateAbbreviation: String {
        if self.isToday {
            return "Today"
        } else if self.isYesterday {
            return "Yesterday"
        } else {
            return self.getDateString(forFormat: "MMM dd, yyyy")
        }
    }
    
    func getDateString(forFormat format: String, andTimeZone timeZone: TimeZone? = nil) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format
        if timeZone != nil {
            dateFormatterPrint.timeZone = timeZone!
        }
        return dateFormatterPrint.string(from: self)
    }
    
    func isEqualToDateIgnoringTime(date: Date) -> Bool {
        let dateComponent1 = Calendar.current.dateComponents([.year, .month, .day, .weekOfMonth, .hour, .minute, .second, .weekday, .weekdayOrdinal], from: self)
        
        let dateComponent2 = Calendar.current.dateComponents([.year, .month, .day, .weekOfMonth, .hour, .minute, .second, .weekday, .weekdayOrdinal], from: date)
        
        return (dateComponent1.year == dateComponent2.year) && (dateComponent1.month == dateComponent2.month) && (dateComponent1.day == dateComponent2.day)
    }
    
    func isLessThanTime(date: Date) -> Bool {
        let dateComponent1 = Calendar.current.dateComponents([.hour, .minute, .second], from: self)
        let dateComponent2 = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
        
        return (dateComponent1.hour! < dateComponent2.hour!)
    }
    
}
