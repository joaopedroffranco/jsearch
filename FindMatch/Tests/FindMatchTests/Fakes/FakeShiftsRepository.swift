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

  func getShifts(for date: Date?) -> Future<ShiftsModel?, Never> {
    Future { promise in promise(.success(self.model)) }
  }
}
