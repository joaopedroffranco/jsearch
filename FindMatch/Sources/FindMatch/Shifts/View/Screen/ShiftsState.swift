//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import JData

enum ShiftsState: Equatable {
  case initial
  case loading
  case loaded(viewModels: [ShiftsViewModel])
  case error
}
