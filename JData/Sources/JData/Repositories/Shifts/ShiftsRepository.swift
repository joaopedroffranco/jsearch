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

  private var cancellable: AnyCancellable?

  public init(
    dataSource: RemoteDataSourceProtocol = URLSessionDataSource(),
    logger: LoggerProtocol = Logger()
  ) {
    self.dataSource = dataSource
    self.logger = logger
  }

  public func getShifts(for date: Date?) -> ShiftsPublisher {
    Future { promise in
      self.cancellable = self.dataSource
        .fetch(request: TemperRequest.shifts(date: date), dataType: ShiftsResponse.self)
        .sink(
          receiveCompletion: { completion in
            switch completion {
            case .failure:
              self.logger.log(topic: "Shifts Repository", message: "The fetch failed")
              promise(.success(nil))
            default: break
            }
          },
          receiveValue: { shifts in promise(.success(shifts)) }
        )
    }.eraseToAnyPublisher()
  }
}
