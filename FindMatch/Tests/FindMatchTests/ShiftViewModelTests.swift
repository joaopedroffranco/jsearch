//
//  Created by João Pedro Fabiano Franco
//

import XCTest
import Nimble
@testable import FindMatch

final class ShiftViewModelTests: XCTestCase {
  func testRegular() {
    // given
    let model = ShiftModelStub.instance

    // when
    let viewModel = ShiftViewModel(shiftModel: model)

    // then
    expect(viewModel.title).to(equal(model.job.clientName))
    expect(viewModel.earningsPerHour).to(equal(model.earningsPerHour))
    expect(viewModel.info).to(equal("\(model.job.category) • 12 km"))
    expect(viewModel.period).to(equal("11:30 - 17:50"))
    expect(viewModel.image).to(equal(.remote(url: model.job.imageURL)))
  }
}
