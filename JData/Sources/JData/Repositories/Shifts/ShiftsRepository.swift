//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import Combine
import JFoundation

public protocol ShiftsRepositoryProtocol: AnyObject {
  func getShifts(for date: Date?) -> Future<ShiftsModel?, Never>
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

  public func getShifts(for date: Date?) -> Future<ShiftsModel?, Never> {
    Future { promise in
      self.cancellable = self.dataSource
        .fetch(request: TemperRequest.shifts(date: date), dataType: ShiftsResponse.self)
        .sink { completion in
          switch completion {
          case let .failure(error):
            self.logger.log(topic: "Shifts Repository", message: error.localizedDescription)
            promise(.success(nil))
          default: break
          }
        } receiveValue: { shifts in
          promise(.success(shifts))
        }
    }
  }
}
