import Foundation
import UIKit

class CalendarHelper
{
    let calendar = Calendar.current
    
    func plusMonth(date: Date) -> Date
    {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    func minusMonth(date: Date) -> Date
    {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    func plusYear(date: Date) -> Date
    {
        return calendar.date(byAdding: .year, value: 1, to: date)!
    }
    
    func minusYear(date: Date) -> Date
    {
        return calendar.date(byAdding: .year, value: -1, to: date)!
    }
    
    func monthString(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
    }
    
    func yearString(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    func daysInMonth(date: Date) -> Int
    {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    func dayOfMonth(date: Date) -> Int
    {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    func firstOfMonth(date: Date) -> Date
    {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    func weekDay(date: Date) -> Int //Sunday -> 0, Monday -> 1 ,..., Saturday -> 6
    {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
    
    func monthsBetweenTwoDates(previousDate: Date, to nextDate: Date) -> Int
    {
        let components = calendar.dateComponents([.month], from: previousDate, to: nextDate)
        guard let months = components.month else{ return 0}
        return months
    }
    
    func yearsBetweenTwoDates(previousDate: Date, to nextDate: Date) -> Int
    {
        let components = calendar.dateComponents([.year], from: previousDate, to: nextDate)
        guard let years = components.year else{ return 0}
        return years
    }
    
}
