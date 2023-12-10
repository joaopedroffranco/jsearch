//
//  Created by João Pedro Fabiano Franco
//

import CoreLocation

public extension CLLocation {
  func kmDistance(from source: CLLocation) -> Int {
    Int(distance(from: source) / 1000)
  }
}
