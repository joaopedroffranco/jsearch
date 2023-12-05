//
//  Created by João Pedro Fabiano Franco
//

import Foundation

public protocol ShiftsModel: Decodable {
  var data: [ShiftModel] { get }
  var count: Int { get }
}

struct ShiftsResponse: Decodable, ShiftsModel {
  let data: [ShiftModel]
  let count: Int

  enum CodingKeys: String, CodingKey {
    case data
    case count = "aggregations"
  }

  enum AggregationsKeys: String, CodingKey {
    case count
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    let aggregationsValues = try values.nestedContainer(keyedBy: AggregationsKeys.self, forKey: .count)

    data = try values.decode([ShiftResponse].self, forKey: .data)
    count = try aggregationsValues.decode(Int.self, forKey: .count)
  }
}
