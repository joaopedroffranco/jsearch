//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import JUI
import JData

struct ShiftViewModel {
  var image: ImageType
  var title: String
  var period: String
  var earningsPerHour: String
  var info: String

  init(shiftModel: ShiftModel) {
    let jobModel = shiftModel.job
    // TODO: get location
    let myLocation = "12 km"
    let category = jobModel.category
    self.init(
      image: .remote(url: jobModel.imageURL),
      title: jobModel.clientName,
      period: "\(shiftModel.startsAt.hour) - \(shiftModel.endsAt.hour)",
      earningsPerHour: shiftModel.earningsPerHour,
      info: "\(category) • \(myLocation)"
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
