//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import JUI
import JData
import CoreLocation

struct ShiftViewModel {
  var id: String
  var image: ImageType
  var title: String
  var period: String
  var earningsPerHour: String
  var info: String

  init(shiftModel: ShiftModel, currentLocation: CLLocation?) {
    let jobModel = shiftModel.job
    let category = jobModel.category

    var info = category
    if let distance = currentLocation?.kmDistance(from: jobModel.address.coordinate) {
      info = "\(category) • \(distance) km"
    }

    var period: String
    if shiftModel.startsAt.isSameDay(shiftModel.endsAt) {
      period = "\(shiftModel.startsAt.hour) - \(shiftModel.endsAt.hour)"
    } else {
      period = "\(shiftModel.startsAt.hour) - \(shiftModel.endsAt.hour) on \(shiftModel.endsAt.beautyString)"
    }

    self.init(
      id: shiftModel.id,
      image: .remote(url: jobModel.imageURL),
      title: jobModel.clientName,
      period: period,
      earningsPerHour: shiftModel.earningsPerHour,
      info: info
    )
  }

  init(
    id: String = UUID().description,
    image: ImageType,
    title: String,
    period: String,
    earningsPerHour: String,
    info: String
  ) {
    self.id = id
    self.image = image
    self.title = title
    self.period = period
    self.earningsPerHour = earningsPerHour
    self.info = info
  }
}

extension ShiftViewModel: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }

  static func == (lhs: ShiftViewModel, rhs: ShiftViewModel) -> Bool {
    lhs.id == rhs.id &&
    lhs.title == rhs.title &&
    lhs.period == rhs.period &&
    lhs.image == rhs.image &&
    lhs.info == rhs.info &&
    lhs.image == rhs.image
  }
}
