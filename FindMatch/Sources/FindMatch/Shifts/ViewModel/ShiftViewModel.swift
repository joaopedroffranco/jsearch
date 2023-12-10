//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import JUI
import JData
import CoreLocation

class ShiftViewModel {
  var image: ImageType
  var title: String
  var period: String
  var earningsPerHour: String
  var info: String

  convenience init(shiftModel: ShiftModel, currentLocation: CLLocation?) {
    let jobModel = shiftModel.job
    let category = jobModel.category

    var info = category
    if let distance = currentLocation?.kmDistance(from: jobModel.address.coordinate) {
      info = "\(category) • \(distance) km"
    }

    self.init(
      image: .remote(url: jobModel.imageURL),
      title: jobModel.clientName,
      period: "\(shiftModel.startsAt.hour) - \(shiftModel.endsAt.hour)", // TODO: Show other day
      earningsPerHour: shiftModel.earningsPerHour,
      info: info
    )
  }

  init(
    image: ImageType,
    title: String,
    period: String,
    earningsPerHour: String,
    info: String
  ) {
    self.image = image
    self.title = title
    self.period = period
    self.earningsPerHour = earningsPerHour
    self.info = info
  }
}

extension ShiftViewModel: Equatable {
  static func == (lhs: ShiftViewModel, rhs: ShiftViewModel) -> Bool {
    lhs.title == rhs.title &&
    lhs.period == rhs.period &&
    lhs.image == rhs.image &&
    lhs.info == rhs.info &&
    lhs.image == rhs.image
  }
}
