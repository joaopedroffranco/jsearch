//
//  Created by João Pedro Fabiano Franco
//

import CoreLocation

public extension CLLocation {
  static let zero: CLLocation = CLLocation(latitude: .zero, longitude: .zero)

  func kmDistance(from source: CLLocation) -> Int {
    Int(distance(from: source) / 1000)
  }
}
