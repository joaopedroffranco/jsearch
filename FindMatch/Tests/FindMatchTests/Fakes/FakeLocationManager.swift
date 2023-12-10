//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import JFoundation
import CoreLocation
@testable import FindMatch

class FakeLocationManager: LocationProtocol {
  var delegate: LocationDelegate?
  var currentLocation: CLLocation?
  var currentStatus: LocationAuthorizationStatus

  init(currentLocation: CLLocation? = nil, currentStatus: LocationAuthorizationStatus = .authorized) {
    self.currentLocation = currentLocation
    self.currentStatus = currentStatus
  }
}
