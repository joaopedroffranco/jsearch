//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import JData

struct ShiftsViewModel {
  var shifts: [ShiftViewModel]

  init?(shiftsModel: ShiftsModel?) {
    guard let shiftsModel, !shiftsModel.data.isEmpty else { return nil }
    self.init(shifts: shiftsModel.data.map { ShiftViewModel(shiftModel: $0) })
  }

  init(shifts: [ShiftViewModel]) {
    self.shifts = shifts
  }
}
