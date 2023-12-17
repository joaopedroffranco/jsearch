//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import Combine
import JFoundation

public typealias ShiftsPublisher = AnyPublisher<ShiftsModel?, Never>

public protocol ShiftsRepositoryProtocol: AnyObject {
  func getShifts(for date: Date?) -> ShiftsPublisher
  func getShifts(for date: Date?) async -> ShiftsModel?
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

  public func getShifts(for date: Date?) async -> ShiftsModel? {
    do {
      let response: ShiftsResponse = try await dataSource.fetch(
        request: TemperRequest.shifts(date: date)
      )
      return response
    } catch {
      logger.log(topic: "Shifts Repository", message: "Couldn't get the shifts models")
      return nil
    }
  }
}
