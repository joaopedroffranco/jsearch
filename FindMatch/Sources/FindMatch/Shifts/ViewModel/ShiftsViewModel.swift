//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import JData

struct ShiftsViewModel {
  var shifts: [ShiftViewModel]

  init?(shifts: ShiftsModel?) {
    guard let shifts else { return nil }
    self.init(shifts: shifts.data.map { ShiftViewModel(shiftModel: $0) })
  }

  init(shifts: [ShiftViewModel]) {
    self.shifts = shifts
  }
}
