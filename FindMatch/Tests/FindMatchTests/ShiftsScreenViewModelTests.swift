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

  func testGetTodayEmpty() {
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

  func testGetTodayPullToRefresh() {
    // given
    let todayModel = ShiftsModelStub.instance()
    let repository = FakeShiftsRepository(with: todayModel)
    let screenViewModel = ShiftsScreenViewModel(shiftsRepository: repository)

    // when
    screenViewModel.getTodayShifts(isPullRefreshing: true)

    // then
    expect(screenViewModel.state).notTo(equal(.loading))
    expect(screenViewModel.currentDate.weekDay).to(equal(Date.today.weekDay))
  }

  // MARK: - Infinite Scroll

  func testGetFollowing() {
    // given
    let todayModel = ShiftsModelStub.instance()
    let followingModel = ShiftsModelStub.instance()
    let repository = FakeShiftsRepository(with: followingModel)
    let screenViewModel = ShiftsScreenViewModel(shiftsRepository: repository)

    guard let todayShiftsViewModel = ShiftsViewModel(shiftsModel: todayModel, from: screenViewModel.currentDate) else {
      fail("Couldn't proceed with the test")
      return
    }
    screenViewModel.state = .loaded(viewModels: [todayShiftsViewModel])

    // when
    screenViewModel.getFollowingShifts()

    // then
    guard
      let followingDate = Date.today.following(),
      let expectedFollowingShiftsViewModel = ShiftsViewModel(shiftsModel: followingModel, from: followingDate) else {
      fail("The expected is nil")
      return
    }

    expect(screenViewModel.isLoadingFollowing).to(beTrue())
    expect(screenViewModel.isLoadingFollowing).toEventually(beFalse())
    expect(screenViewModel.state).toEventually(equal(.loaded(viewModels: [todayShiftsViewModel] + [expectedFollowingShiftsViewModel])))
    expect(screenViewModel.currentDate.weekDay).toEventually(equal(followingDate.weekDay))
    expect(screenViewModel.currentDate.weekDay).toEventually(equal(expectedFollowingShiftsViewModel.day))
  }

  func testGetFollowingWhenIsAlreadyGetting() {
    // given
    let todayModel = ShiftsModelStub.instance()
    let followingModel = ShiftsModelStub.instance()
    let repository = FakeShiftsRepository(with: followingModel)
    let screenViewModel = ShiftsScreenViewModel(shiftsRepository: repository)

    guard let todayShiftsViewModel = ShiftsViewModel(shiftsModel: todayModel, from: screenViewModel.currentDate) else {
      fail("Couldn't proceed with the test")
      return
    }
    screenViewModel.state = .loaded(viewModels: [todayShiftsViewModel])

    // when
    screenViewModel.isLoadingFollowing = true
    screenViewModel.getFollowingShifts()

    // then
    guard
      let followingDate = Date.today.following(),
      let expectedFollowingShiftsViewModel = ShiftsViewModel(shiftsModel: followingModel, from: followingDate) else {
      fail("The expected is nil")
      return
    }

    expect(screenViewModel.isLoadingFollowing).to(beTrue())
    expect(screenViewModel.isLoadingFollowing).toNotEventually(beFalse())
    expect(screenViewModel.state).toNotEventually(equal(.loaded(viewModels: [todayShiftsViewModel] + [expectedFollowingShiftsViewModel])))
    expect(screenViewModel.state).toEventually(equal(.loaded(viewModels: [todayShiftsViewModel])))
    expect(screenViewModel.currentDate.weekDay).toEventually(equal(Date.today.weekDay))
    expect(screenViewModel.currentDate.weekDay).toEventually(equal(todayShiftsViewModel.day))
  }

  func testGetFollowingEmpty() {
    // given
    let todayModel = ShiftsModelStub.instance()
    let followingModel = ShiftsModelStub.instance(numberOfShifts: 0)
    let repository = FakeShiftsRepository(with: followingModel)
    let screenViewModel = ShiftsScreenViewModel(shiftsRepository: repository)

    guard let todayShiftsViewModel = ShiftsViewModel(shiftsModel: todayModel, from: screenViewModel.currentDate) else {
      fail("Couldn't proceed with the test")
      return
    }
    screenViewModel.state = .loaded(viewModels: [todayShiftsViewModel])

    // when
    screenViewModel.getFollowingShifts()

    // then
    expect(screenViewModel.isLoadingFollowing).toNotEventually(beTrue())
    expect(screenViewModel.isLoadingFollowing).to(beFalse())
    expect(screenViewModel.state).toEventually(equal(.loaded(viewModels: [todayShiftsViewModel])))
    expect(screenViewModel.currentDate.weekDay).toEventually(equal(Date.today.weekDay))
    expect(screenViewModel.currentDate.weekDay).toEventually(equal(todayShiftsViewModel.day))
  }

  func testGetFollowingNil() {
    // given
    let todayModel = ShiftsModelStub.instance()
    let followingModel: ShiftsModelStub? = nil
    let repository = FakeShiftsRepository(with: followingModel)
    let screenViewModel = ShiftsScreenViewModel(shiftsRepository: repository)

    guard let todayShiftsViewModel = ShiftsViewModel(shiftsModel: todayModel, from: screenViewModel.currentDate) else {
      fail("Couldn't proceed with the test")
      return
    }
    screenViewModel.state = .loaded(viewModels: [todayShiftsViewModel])

    // when
    screenViewModel.getFollowingShifts()

    // then
    expect(screenViewModel.isLoadingFollowing).toNotEventually(beTrue())
    expect(screenViewModel.isLoadingFollowing).to(beFalse())
    expect(screenViewModel.state).toEventually(equal(.loaded(viewModels: [todayShiftsViewModel])))
    expect(screenViewModel.currentDate.weekDay).toEventually(equal(Date.today.weekDay))
    expect(screenViewModel.currentDate.weekDay).toEventually(equal(todayShiftsViewModel.day))
  }

  func testGetFollowingWhenInitial() {
    // given
    let todayModel = ShiftsModelStub.instance()
    let followingModel = ShiftsModelStub.instance()
    let repository = FakeShiftsRepository(with: followingModel)
    let screenViewModel = ShiftsScreenViewModel(shiftsRepository: repository)

    guard let todayShiftsViewModel = ShiftsViewModel(shiftsModel: todayModel, from: screenViewModel.currentDate) else {
      fail("Couldn't proceed with the test")
      return
    }
    screenViewModel.state = .initial

    // when
    screenViewModel.getFollowingShifts()

    // then
    expect(screenViewModel.isLoadingFollowing).toNotEventually(beTrue())
    expect(screenViewModel.isLoadingFollowing).to(beFalse())
    expect(screenViewModel.state).toEventually(equal(.initial))
    expect(screenViewModel.currentDate.weekDay).toEventually(equal(Date.today.weekDay))
    expect(screenViewModel.currentDate.weekDay).toEventually(equal(todayShiftsViewModel.day))
  }

  func testGetFollowingWhenError() {
    // given
    let todayModel = ShiftsModelStub.instance()
    let followingModel = ShiftsModelStub.instance()
    let repository = FakeShiftsRepository(with: followingModel)
    let screenViewModel = ShiftsScreenViewModel(shiftsRepository: repository)

    guard let todayShiftsViewModel = ShiftsViewModel(shiftsModel: todayModel, from: screenViewModel.currentDate) else {
      fail("Couldn't proceed with the test")
      return
    }
    screenViewModel.state = .error

    // when
    screenViewModel.getFollowingShifts()

    // then
    expect(screenViewModel.isLoadingFollowing).toNotEventually(beTrue())
    expect(screenViewModel.isLoadingFollowing).to(beFalse())
    expect(screenViewModel.state).toEventually(equal(.error))
    expect(screenViewModel.currentDate.weekDay).toEventually(equal(Date.today.weekDay))
    expect(screenViewModel.currentDate.weekDay).toEventually(equal(todayShiftsViewModel.day))
  }

  func testGetFollowingWhenNotNeeded() {
    // given
    let todayModel = ShiftsModelStub.instance()
    let followingModel = ShiftsModelStub.instance()
    let repository = FakeShiftsRepository(with: followingModel)
    let screenViewModel = ShiftsScreenViewModel(shiftsRepository: repository)

    guard let todayShiftsViewModel = ShiftsViewModel(shiftsModel: todayModel, from: screenViewModel.currentDate) else {
      fail("Couldn't proceed with the test")
      return
    }
    screenViewModel.state = .loaded(viewModels: [todayShiftsViewModel])

    // when
    screenViewModel.getFollowingShiftsIfNeeded(section: 0, index: 1)

    // then
    expect(screenViewModel.state).toEventually(equal(.loaded(viewModels: [todayShiftsViewModel])))
  }

  func testGetFollowingWhenNeeded() {
    // given
    let todayModel = ShiftsModelStub.instance()
    let followingModel = ShiftsModelStub.instance()
    let repository = FakeShiftsRepository(with: followingModel)
    let screenViewModel = ShiftsScreenViewModel(shiftsRepository: repository)

    guard let shiftsViewModel = ShiftsViewModel(shiftsModel: todayModel, from: screenViewModel.currentDate) else {
      fail("Couldn't proceed with the test")
      return
    }
    screenViewModel.state = .loaded(viewModels: [shiftsViewModel])

    // when
    screenViewModel.getFollowingShiftsIfNeeded(section: 0, index: 4)

    // then
    guard
      let followingDate = Date.today.following(),
      let expectedFollowingShiftsViewModel = ShiftsViewModel(shiftsModel: followingModel, from: followingDate) else {
      fail("The expected is nil")
      return
    }

    expect(screenViewModel.state).toEventually(equal(.loaded(viewModels: [shiftsViewModel] + [expectedFollowingShiftsViewModel])))
  }

  func testGetFollowingWhenOutOfIndex() {
    // given
    let todayModel = ShiftsModelStub.instance()
    let followingModel = ShiftsModelStub.instance()
    let repository = FakeShiftsRepository(with: followingModel)
    let screenViewModel = ShiftsScreenViewModel(shiftsRepository: repository)

    guard let shiftsViewModel = ShiftsViewModel(shiftsModel: todayModel, from: screenViewModel.currentDate) else {
      fail("Couldn't proceed with the test")
      return
    }
    screenViewModel.state = .loaded(viewModels: [shiftsViewModel])

    // when
    screenViewModel.getFollowingShiftsIfNeeded(section: 10, index: 4)

    // then
    guard
      let followingDate = Date.today.following(),
      let expectedFollowingShiftsViewModel = ShiftsViewModel(shiftsModel: followingModel, from: followingDate) else {
      fail("The expected is nil")
      return
    }

    expect(screenViewModel.state).toNotEventually(equal(.loaded(viewModels: [shiftsViewModel, expectedFollowingShiftsViewModel])))
    expect(screenViewModel.state).toEventually(equal(.loaded(viewModels: [shiftsViewModel])))
  }

  func testGetFollowingTwiceWhenReachEndOfFirstDay() {
    // given
    let todayModel = ShiftsModelStub.instance()
    let followingModel = ShiftsModelStub.instance()
    let repository = FakeShiftsRepository(with: followingModel)
    let screenViewModel = ShiftsScreenViewModel(shiftsRepository: repository)

    guard let shiftsViewModel = ShiftsViewModel(shiftsModel: todayModel, from: screenViewModel.currentDate) else {
      fail("Couldn't proceed with the test")
      return
    }
    screenViewModel.state = .loaded(viewModels: [shiftsViewModel, shiftsViewModel])

    // when
    screenViewModel.getFollowingShiftsIfNeeded(section: 0, index: 4)

    // then
    guard
      let followingDate = Date.today.following(),
      let expectedFollowingShiftsViewModel = ShiftsViewModel(shiftsModel: followingModel, from: followingDate) else {
      fail("The expected is nil")
      return
    }

    expect(screenViewModel.state).toNotEventually(equal(.loaded(viewModels: [shiftsViewModel, shiftsViewModel, expectedFollowingShiftsViewModel])))
    expect(screenViewModel.state).toEventually(equal(.loaded(viewModels: [shiftsViewModel, shiftsViewModel])))
  }

  func testGetFollowingTwiceWhenReachEndOfSecondDay() {
    // given
    let todayModel = ShiftsModelStub.instance()
    let followingModel = ShiftsModelStub.instance()
    let repository = FakeShiftsRepository(with: followingModel)
    let screenViewModel = ShiftsScreenViewModel(shiftsRepository: repository)

    guard let shiftsViewModel = ShiftsViewModel(shiftsModel: todayModel, from: screenViewModel.currentDate) else {
      fail("Couldn't proceed with the test")
      return
    }
    screenViewModel.state = .loaded(viewModels: [shiftsViewModel, shiftsViewModel])

    // when
    screenViewModel.getFollowingShiftsIfNeeded(section: 1, index: 4)

    // then
    guard
      let followingDate = Date.today.following(),
      let expectedFollowingShiftsViewModel = ShiftsViewModel(shiftsModel: followingModel, from: followingDate) else {
      fail("The expected is nil")
      return
    }

    expect(screenViewModel.state).toEventually(equal(.loaded(viewModels: [shiftsViewModel, shiftsViewModel, expectedFollowingShiftsViewModel])))
  }

  func testGetFollowingTwiceWhenReachMiddleOfSecondDay() {
    // given
    let todayModel = ShiftsModelStub.instance()
    let followingModel = ShiftsModelStub.instance()
    let repository = FakeShiftsRepository(with: followingModel)
    let screenViewModel = ShiftsScreenViewModel(shiftsRepository: repository)

    guard let shiftsViewModel = ShiftsViewModel(shiftsModel: todayModel, from: screenViewModel.currentDate) else {
      fail("Couldn't proceed with the test")
      return
    }
    screenViewModel.state = .loaded(viewModels: [shiftsViewModel, shiftsViewModel])

    // when
    screenViewModel.getFollowingShiftsIfNeeded(section: 1, index: 2)

    // then
    guard
      let followingDate = Date.today.following(),
      let expectedFollowingShiftsViewModel = ShiftsViewModel(shiftsModel: followingModel, from: followingDate) else {
      fail("The expected is nil")
      return
    }

    expect(screenViewModel.state).toNotEventually(equal(.loaded(viewModels: [shiftsViewModel, shiftsViewModel, expectedFollowingShiftsViewModel])))
    expect(screenViewModel.state).toEventually(equal(.loaded(viewModels: [shiftsViewModel, shiftsViewModel])))
  }
}
