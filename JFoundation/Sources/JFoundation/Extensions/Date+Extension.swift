//
//  Created by João Pedro Fabiano Franco
//

import Foundation

public extension Date {
  static var today: Date { Date() }

  var weekDay: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "EE d M"
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
}
