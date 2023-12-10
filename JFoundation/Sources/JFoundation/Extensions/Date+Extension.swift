//
//  Created by João Pedro Fabiano Franco
//

import Foundation

public extension Date {
  static var today: Date { Date() }

  var string: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: self)
  }

  var beautyString: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd, MMM"
    return formatter.string(from: self)
  }

  var weekDay: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE d MMMM"
    return formatter.string(from: self)
  }

  var hour: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter.string(from: self)
  }

  func date(hour: Int, minutes: Int) -> Date {
    let calendar = Calendar.current
    return calendar.date(bySettingHour: hour, minute: minutes, second: .zero, of: self) ?? self
  }

  func following(_ value: Int = 1) -> Date? {
    Calendar.current.date(byAdding: .day, value: value, to: self)
  }

  func isSameDay(_ date: Date) -> Bool {
    Calendar.current.isDate(self, equalTo: date, toGranularity: .day)
  }
}
