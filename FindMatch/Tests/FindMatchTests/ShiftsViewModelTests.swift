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
    let viewModel = ShiftsViewModel(shiftsModel: model, from: .today)

    // then
    expect(viewModel?.shiftViewModels).notTo(beEmpty())
    expect(viewModel?.shiftViewModels.count).to(equal(5))
    expect(viewModel?.day).to(equal(Date.today.weekDay))
  }

  func testEmpty() {
    // given
    let model = ShiftsModelStub.instance(numberOfShifts: 0)

    // when
    let viewModel = ShiftsViewModel(shiftsModel: model, from: .today)

    // then
    expect(viewModel).to(beNil())
  }

  func testNil() {
    // given
    let model: ShiftsModelStub? = nil

    // when
    let viewModel = ShiftsViewModel(shiftsModel: model, from: .today)

    // then
    expect(viewModel).to(beNil())
  }
}

