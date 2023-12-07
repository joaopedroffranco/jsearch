//
//  Created by João Pedro Fabiano Franco
//

import XCTest
import Nimble
@testable import FindMatch

final class ShiftsViewModelTests: XCTestCase {
  func testRegular() {
    // given
    let model = ShiftsModelStub.instance()

    // when
    let viewModel = ShiftsViewModel(shiftsModel: model)

    // then
    expect(viewModel?.shifts).notTo(beEmpty())
    expect(viewModel?.shifts.count).to(equal(5))
  }

  func testEmpty() {
    // given
    let model = ShiftsModelStub.instance(numberOfShifts: 0)

    // when
    let viewModel = ShiftsViewModel(shiftsModel: model)

    // then
    expect(viewModel?.shifts).to(beNil())
  }

  func testNil() {
    // given
    let model: ShiftsModelStub? = nil

    // when
    let viewModel = ShiftsViewModel(shiftsModel: model)

    // then
    expect(viewModel?.shifts).to(beNil())
  }
}

