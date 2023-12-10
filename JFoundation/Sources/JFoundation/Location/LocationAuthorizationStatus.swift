//
//  Created by João Pedro Fabiano Franco
//

import CoreLocation

public enum LocationAuthorizationStatus {
  case requesting
  case authorized
  case denied

  init(from status: CLAuthorizationStatus) {
    switch status {
    case .notDetermined: self = .requesting
    case .authorizedAlways, .authorizedWhenInUse: self = .authorized
    default: self = .denied
    }
  }
}
