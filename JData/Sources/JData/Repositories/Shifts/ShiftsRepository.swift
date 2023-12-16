//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import Combine
import JFoundation

public typealias ShiftsPublisher = AnyPublisher<ShiftsModel?, Never>

public protocol ShiftsRepositoryProtocol: AnyObject {
  func getShifts(for date: Date?) -> ShiftsPublisher
}

public class ShiftsRepository: ShiftsRepositoryProtocol {
  var dataSource: RemoteDataSourceProtocol
  var logger: LoggerProtocol

  public init(
    dataSource: RemoteDataSourceProtocol = URLSessionDataSource(),
    logger: LoggerProtocol = Logger()
  ) {
    self.dataSource = dataSource
    self.logger = logger
  }

  public func getShifts(for date: Date?) -> ShiftsPublisher {
    dataSource
      .fetch(
        request: TemperRequest.shifts(date: date),
        dataType: ShiftsResponse.self
      )
      .map { $0 }
      .replaceError(with: nil)
      .eraseToAnyPublisher()
  }
}
