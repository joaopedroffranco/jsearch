//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import CoreLocation

public protocol AddressModel: Decodable {
  var coordinate: CLLocation { get }
}

struct AddressResponse: Decodable, AddressModel {
  let coordinate: CLLocation

  enum CodingKeys: String, CodingKey {
    case coordinates = "geo"
  }

  enum CoordinateKeys: String, CodingKey {
    case latitude = "lat"
    case longitude = "lon"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    let coordinateValues = try values.nestedContainer(keyedBy: CoordinateKeys.self, forKey: .coordinates)

    let latitude = try coordinateValues.decode(CLLocationDegrees.self, forKey: .latitude)
    let longitude = try coordinateValues.decode(CLLocationDegrees.self, forKey: .longitude)

    coordinate = CLLocation(latitude: latitude, longitude: longitude)
  }
}
