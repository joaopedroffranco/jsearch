//
//  Created by João Pedro Fabiano Franco
//

import XCTest
import Nimble
import Combine
@testable import JData

final class ShiftsRepositoryTests: XCTestCase {
  var cancellable: AnyCancellable?

  func testRegularResponse() {
    // given
    let repository = ShiftsRepository(dataSource: FakeDataSource(jsonFile: JSONFile.shifts))

    // when
    var expectedResponse: ShiftsModel?
    repository.getShifts(for: nil)
      .sink(receiveValue: { response in
        expectedResponse = response
      })
      .cancel()

    // then
    expect(expectedResponse?.count).to(equal(3))
    expect(expectedResponse?.data.count).to(equal(3))
    expect(expectedResponse?.data).notTo(beNil())
  }

  func testInvalidResponse() {
    // given
    let repository = ShiftsRepository(dataSource: FakeDataSource(jsonFile: JSONFile.invalidShifts))

    // when
    var expectedResponse: ShiftsModel?
    repository.getShifts(for: nil)
      .sink(receiveValue: { response in
        expectedResponse = response
      })
      .cancel()

    // then
    expect(expectedResponse?.count).to(beNil())
    expect(expectedResponse?.data.count).to(beNil())
    expect(expectedResponse?.data).to(beNil())
  }

  func testEmptyResponse() {
    // given
    let repository = ShiftsRepository(dataSource: FakeDataSource(jsonFile: JSONFile.emptyShifts))

    // when
    var expectedResponse: ShiftsModel?
    repository.getShifts(for: nil)
      .sink(receiveValue: { response in
        expectedResponse = response
      })
      .cancel()

    // then
    expect(expectedResponse?.count).to(equal(0))
    expect(expectedResponse?.data).to(beEmpty())
  }
}
