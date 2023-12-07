//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import JData

class ShiftsViewModel {
  var day: String
  var shiftViewModels: [ShiftViewModel]

  convenience init?(shiftsModel: ShiftsModel?, from date: Date) {
    guard let shiftsModel, !shiftsModel.data.isEmpty else { return nil }
    let shiftViewModels = shiftsModel.data.map { ShiftViewModel(shiftModel: $0) }
    self.init(day: date.weekDay, shiftViewModels: shiftViewModels)
  }

  init(day: String, shiftViewModels: [ShiftViewModel]) {
    self.day = day
    self.shiftViewModels = shiftViewModels
  }
}
