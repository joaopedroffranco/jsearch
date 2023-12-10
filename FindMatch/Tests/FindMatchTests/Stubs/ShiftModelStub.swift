//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import CoreLocation
@testable import JData

public struct ShiftsModelStub: ShiftsModel {
  public var data: [ShiftModel]
  public var count: Int

  static func instance(numberOfShifts: Int = 5) -> ShiftsModelStub {
    ShiftsModelStub(
      data: Array(repeating: ShiftModelStub.instance, count: numberOfShifts),
      count: numberOfShifts
    )
  }
}

public struct ShiftModelStub: ShiftModel {
  public var id: String
  public var startsAt: Date
  public var endsAt: Date
  public var earningsPerHour: String
  public var job: JobModel

  public static let instance = ShiftModelStub(
    id: UUID().uuidString,
    startsAt: .today.date(hour: 11, minutes: 30),
    endsAt: .today.date(hour: 17, minutes: 50),
    earningsPerHour: "$ 13",
    job: JobModelStub.instance
  )

  public static let differentDates = ShiftModelStub(
    id: UUID().uuidString,
    startsAt: .today.date(hour: 11, minutes: 30),
    endsAt: .today.following()?.date(hour: 17, minutes: 50) ?? .today,
    earningsPerHour: "$ 13",
    job: JobModelStub.instance
  )
}

public struct JobModelStub: JobModel {
  public var clientName: String
  public var imageURL: URL
  public var category: String
  public var address: AddressModel

  public static let instance = JobModelStub(
    clientName: "Café",
    imageURL: URL(string: "https://tmpr-photos.ams3.digitaloceanspaces.com/hero380/160951.jpg")!,
    category: "Serving",
    address: AddressModelStub.instance
  )
}

public struct AddressModelStub: AddressModel {
  public var coordinate: CLLocation

  public static let instance = AddressModelStub(coordinate: .zero)
}
