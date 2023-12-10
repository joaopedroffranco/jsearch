//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import CoreLocation
import JData

class ShiftsViewModel {
  var day: String
  var shiftViewModels: [ShiftViewModel]

  convenience init?(shiftsModel: ShiftsModel?, from date: Date, currentLocation: CLLocation? = nil) {
    guard let shiftsModel, !shiftsModel.data.isEmpty else { return nil }
    let shiftViewModels = shiftsModel.data.map { ShiftViewModel(shiftModel: $0, currentLocation: currentLocation) }
    self.init(day: date.weekDay, shiftViewModels: shiftViewModels)
  }


  init(day: String, shiftViewModels: [ShiftViewModel]) {
    self.day = day
    self.shiftViewModels = shiftViewModels
  }
}

extension ShiftsViewModel: Equatable {
  static func == (lhs: ShiftsViewModel, rhs: ShiftsViewModel) -> Bool {
    lhs.day == rhs.day &&
    lhs.shiftViewModels == rhs.shiftViewModels
  }
}
