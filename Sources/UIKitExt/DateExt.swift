import Foundation

private var _localizedDateFormatter: DateFormatter?

extension Date {
    public func localizedString(with format: String) -> String
    {
        if _localizedDateFormatter == nil
        {
            _localizedDateFormatter = DateFormatter()
            _localizedDateFormatter?.locale = Locale.current
            _localizedDateFormatter?.timeZone = TimeZone.autoupdatingCurrent
        }
        _localizedDateFormatter!.dateFormat = format
        let strTimeFormatted = _localizedDateFormatter!.string(from: self)
        return strTimeFormatted
    }
    
    public func stringWithRFC3339Format() -> String
    {
        return localizedString(with: "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'")
    }
    
    public func shortedVrijeme(includeSeconds:Bool=false) -> String
    {
        let calendar = Calendar.current
        let units: Set<Calendar.Component> = [.year, .month, .day]
        let comp = calendar.dateComponents(units, from: self)
        let compToday = calendar.dateComponents(units, from: Date())
        
        var format = "HH:mm"
        if includeSeconds {
            format.append(":ss")
        }
        
        if comp.year != compToday.year {
            format = "dd.MM.yyyy. \(format)"
        } else if comp.month != compToday.month || comp.day != compToday.day {
            format = "dd.MM. \(format)"
        }
        
        return localizedString(with: format)
        
    }
    
    public func shortedDay() -> String
    {
        let calendar = Calendar.current
        let units: Set<Calendar.Component> = [.year, .month, .day]
        let comp = calendar.dateComponents(units, from: self)
        let compToday = calendar.dateComponents(units, from: Date())
        
        if comp.year != compToday.year {
            return localizedString(with: "dd.MM.yyyy.")
        } else if comp.month != compToday.month || comp.day != compToday.day {
            return localizedString(with: "dd.MM.")
        } else {
            return NSLocalizedString("Today", comment: "")
        }
    }
}

extension DateFormatter {
    
    private static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.locale = Locale.current
        return formatter
    }()
    
    private static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.locale = Locale.current
        return formatter
    }()
    
    public static func iso8601(from date: String) -> Date? {
        if let withFractional = DateFormatter.iso8601Full.date(from: date) {
            return withFractional
        }
        
        if let short = DateFormatter.iso8601.date(from: date) {
            return short
        }
        
        return nil
    }

}
