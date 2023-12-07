//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import JData
@testable import FindMatch

class FakeShiftsRepository: ShiftsRepositoryProtocol {
  let model: ShiftsModel?

  init(with model: ShiftsModel?) {
    self.model = model
  }

  func getShifts(for date: Date?) async -> ShiftsModel? { model }
}
