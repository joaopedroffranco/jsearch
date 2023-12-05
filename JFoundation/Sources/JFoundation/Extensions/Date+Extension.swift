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
    formatter.dateFormat = "hh:mm"
    return formatter.string(from: self)
  }
}
