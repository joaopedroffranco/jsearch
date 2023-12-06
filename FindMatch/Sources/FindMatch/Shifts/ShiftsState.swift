//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import JData

enum ShiftsState {
  case initial
  case loading
  case loaded(viewModel: ShiftsViewModel)
  case error
}
