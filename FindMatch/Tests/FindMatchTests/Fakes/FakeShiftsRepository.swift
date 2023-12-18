//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import JData
import Combine
@testable import FindMatch

class FakeShiftsRepository: ShiftsRepositoryProtocol {
  let model: ShiftsModel?

  init(with model: ShiftsModel?) {
    self.model = model
  }

  func getShifts(for date: Date?) -> ShiftsPublisher {
    Just(model).eraseToAnyPublisher()
  }

  func getShifts(for date: Date?) async -> ShiftsModel? {
    model
  }
}
