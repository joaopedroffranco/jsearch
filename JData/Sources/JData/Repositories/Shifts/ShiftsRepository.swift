//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import Combine
import JFoundation

public protocol ShiftsRepositoryProtocol: AnyObject {
  func getShifts(for date: Date?) -> AnyPublisher<ShiftsModel?, Never>
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

  public func getShifts(for date: Date?) -> AnyPublisher<ShiftsModel?, Never> {
    let subject = PassthroughSubject<ShiftsModel?, Never>()
    cancellable = dataSource
      .fetch(request: TemperRequest.shifts(date: date), dataType: ShiftsResponse.self)
      .sink { completion in
        switch completion {
        case let .failure(error):
          self.logger.log(topic: "Shifts Repository", message: error.localizedDescription)
          subject.send(nil)
        default: break
        }
      } receiveValue: { shifts in
        subject.send(shifts)
      }

    return subject.eraseToAnyPublisher()
  }
}
