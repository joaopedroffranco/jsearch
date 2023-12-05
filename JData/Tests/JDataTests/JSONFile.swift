//
//  Created by João Pedro Fabiano Franco
//

import Foundation

enum JSONFile: JSONFileProtocol {
  case shifts
  case invalidShifts
  case emptyShifts

  var name: String {
    switch self {
    case .shifts: return "shifts"
    case .invalidShifts: return "invalidShifts"
    case .emptyShifts: return "emptyShifts"
    }
  }
}
