//
//  Created by João Pedro Fabiano Franco
//

import Foundation

enum TemperRequest: Requestable {
  case shifts(date: Date?)

  var method: RequestMethod { .get }

  var host: String { "https://temper.works/api/v3" }

  var endpoint: String {
    switch self {
    case .shifts: return "/shifts"
    }
  }

  var params: [String: String]? {
    switch self {
    case let .shifts(date):
      guard let date else { return nil }
      return ["filter[date]": date.description]
    }
  }

  var headers: [String: String]? { nil }

  var cachePolicy: URLRequest.CachePolicy { .reloadIgnoringLocalCacheData }
}
