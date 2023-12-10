//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import JFoundation

enum ShiftsScreenPreviewModel {
  static func shiftsViewModel(numberOfShifts: Int = 5) -> ShiftsViewModel {
    let viewModels = (0..<numberOfShifts).map { shiftViewModel(id: $0.description) }
    return ShiftsViewModel(day: Date.today.weekDay, shiftViewModels: viewModels)
  }

  static func shiftViewModel(id: String = UUID().description) -> ShiftViewModel {
    ShiftViewModel(
      id: id,
      image: .remote(url: URL(string: "https://tmpr-photos2.fra1.digitaloceanspaces.com/hero/670935.jpg")!),
      title: "Café",
      period: "11:30 - 17:30",
      earningsPerHour: "$ 13",
      info: "Serving • 12 km"
    )
  }

  static var shiftViewModel = ShiftsScreenPreviewModel.shiftViewModel()
}
