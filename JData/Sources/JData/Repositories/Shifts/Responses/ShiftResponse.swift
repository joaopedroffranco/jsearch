//
//  Created by João Pedro Fabiano Franco
//

import Foundation

public protocol ShiftModel {
  var id: String { get }
  var startsAt: Date { get }
  var endsAt: Date { get }
  var earningsPerHour: String { get }
  var job: JobModel { get }
}

struct ShiftResponse: Decodable, ShiftModel {
  let id: String
  let startsAt: Date
  let endsAt: Date
  let earningsPerHour: String
  let job: JobModel

  static var isoDateFormatter = ISO8601DateFormatter()

  enum CodingKeys: String, CodingKey {
    case id
    case startsAt = "starts_at"
    case endsAt = "ends_at"
    case earningsPerHour = "earnings_per_hour"
    case job
  }

  enum EarningsPerHourKeys: String, CodingKey {
    case currency
    case amount
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    // id
    id = try values.decode(String.self, forKey: .id)

    // startsAt
    guard let startsAtValue = ShiftResponse.isoDateFormatter.date(from: try values.decode(String.self, forKey: .startsAt)) else {
      throw DecodingError.dataCorruptedError(forKey: .startsAt, in: values, debugDescription: "Expecting a valid date format")
    }

    startsAt = startsAtValue

    // endsAt
    guard let endsAtValue = ShiftResponse.isoDateFormatter.date(from: try values.decode(String.self, forKey: .endsAt)) else {
      throw DecodingError.dataCorruptedError(forKey: .startsAt, in: values, debugDescription: "Expecting a valid date format")
    }

    endsAt = endsAtValue

    // earningsPerHour
    let earningsPerHourValues = try values.nestedContainer(keyedBy: EarningsPerHourKeys.self, forKey: .earningsPerHour)

    let earningsPerHourCurrencyValue = try earningsPerHourValues.decode(String.self, forKey: .currency)
    let earningsPerHourAmountValue = try earningsPerHourValues.decode(Double.self, forKey: .amount)

    earningsPerHour = "\(Currency(shorthand: earningsPerHourCurrencyValue).sign) \(earningsPerHourAmountValue)"

    // job
    job = try values.decode(JobResponse.self, forKey: .job)
  }
}
