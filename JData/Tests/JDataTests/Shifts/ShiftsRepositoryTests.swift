//
//  Created by João Pedro Fabiano Franco
//

import XCTest
import Nimble
@testable import JData

final class ShiftsRepositoryTests: XCTestCase {
  var repository: ShiftsRepository?

  func testRegularResponse() async {
    // given
    repository = ShiftsRepository(dataSource: FakeDataSource(jsonFile: JSONFile.shifts))

    // when
    let response = await repository?.getShifts(for: nil)

    // then
    expect(response?.count).to(equal(3))
    expect(response?.data.count).to(equal(3))
    expect(response?.data).notTo(beNil())
  }

  func testInvalidResponse() async {
    // given
    repository = ShiftsRepository(dataSource: FakeDataSource(jsonFile: JSONFile.invalidShifts))

    // when
    let response = await repository?.getShifts(for: nil)

    // then
    expect(response?.count).to(beNil())
    expect(response?.data.count).to(beNil())
    expect(response?.data).to(beNil())
  }

  func testEmptyResponse() async {
    // given
    repository = ShiftsRepository(dataSource: FakeDataSource(jsonFile: JSONFile.emptyShifts))

    // when
    let response = await repository?.getShifts(for: nil)

    // then
    expect(response?.count).to(equal(0))
    expect(response?.data).to(beEmpty())
  }
}
