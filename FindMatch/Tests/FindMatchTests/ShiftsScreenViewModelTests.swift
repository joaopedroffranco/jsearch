//
//  Created by João Pedro Fabiano Franco
//

import XCTest
import Nimble
@testable import FindMatch

final class ShiftsScreenViewModelTests: XCTestCase {
  func testInitial() {
    // given & when
    let screenViewModel = ShiftsScreenViewModel()

    // then
    expect(screenViewModel.state).to(equal(.initial))
  }

  func testGetToday() {
    // given
    let todayModel = ShiftsModelStub.instance()
    let repository = FakeShiftsRepository(with: todayModel)
    let screenViewModel = ShiftsScreenViewModel(shiftsRepository: repository)

    // when
    screenViewModel.getTodayShifts()

    // then
    expect(screenViewModel.state).to(equal(.loading))

    guard let expectedTodayShiftsViewModel = ShiftsViewModel(shiftsModel: todayModel, from: .today) else {
      fail("The expected is nil")
      return
    }
    expect(screenViewModel.state).toEventually(equal(.loaded(viewModels: [expectedTodayShiftsViewModel])))
  }

  func testGetTodayWithEmptyShifts() {
    // given
    let emptyModel = ShiftsModelStub.instance(numberOfShifts: 0)
    let repository = FakeShiftsRepository(with: emptyModel)
    let screenViewModel = ShiftsScreenViewModel(shiftsRepository: repository)

    // when
    screenViewModel.getTodayShifts()

    // then
    expect(screenViewModel.state).toEventually(equal(.error))
  }

  func testGetTodayNil() {
    // given
    let nilModel: ShiftsModelStub? = nil
    let repository = FakeShiftsRepository(with: nilModel)
    let screenViewModel = ShiftsScreenViewModel(shiftsRepository: repository)

    // when
    screenViewModel.getTodayShifts()

    // then
    expect(screenViewModel.state).toEventually(equal(.error))
  }
}
