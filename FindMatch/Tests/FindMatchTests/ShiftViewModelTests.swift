//
//  Created by João Pedro Fabiano Franco
//

import XCTest
import Nimble
import CoreLocation
@testable import FindMatch

final class ShiftViewModelTests: XCTestCase {
  func testRegular() {
    // given
    let model = ShiftModelStub.instance
    let location = CLLocation(latitude: 10, longitude: 10)

    // when
    let viewModel = ShiftViewModel(shiftModel: model, currentLocation: location)

    // then
    expect(viewModel.title).to(equal(model.job.clientName))
    expect(viewModel.earningsPerHour).to(equal(model.earningsPerHour))
    expect(viewModel.info).to(equal("\(model.job.category) • \(model.job.address.coordinate.kmDistance(from: location)) km"))
    expect(viewModel.period).to(equal("11:30 - 17:50"))
    expect(viewModel.image).to(equal(.remote(url: model.job.imageURL)))
  }

  func testLocationNil() {
    // given
    let model = ShiftModelStub.instance

    // when
    let viewModel = ShiftViewModel(shiftModel: model, currentLocation: nil)

    // then
    expect(viewModel.title).to(equal(model.job.clientName))
    expect(viewModel.earningsPerHour).to(equal(model.earningsPerHour))
    expect(viewModel.info).to(equal(model.job.category))
    expect(viewModel.period).to(equal("11:30 - 17:50"))
    expect(viewModel.image).to(equal(.remote(url: model.job.imageURL)))
  }
}
