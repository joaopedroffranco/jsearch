//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import JFoundation
@testable import FindMatch

class FakeFindMatchRouter: FindMatchRouterDelegate {
  var didFilter = false
  var didKaart = false
  var didLogin = false
  var didSignUp = false
  var didDismiss = false

  func goFilters() {
    didFilter = true
  }

  func goKaart() {
    didKaart = true
  }

  func goLogin() {
    didLogin = true
  }

  func goSignUp() {
    didSignUp = true
  }

  func dismiss() {
    didDismiss = true
  }
}
