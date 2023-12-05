//
//  Created by João Pedro Fabiano Franco
//

import Foundation

public protocol ShiftsRepositoryProtocol: AnyObject {
  func getShifts(for date: Date?) async -> ShiftsModel?
}

public class ShiftsRepository: ShiftsRepositoryProtocol {
  var dataSource: RemoteDataSourceProtocol

  public init(dataSource: RemoteDataSourceProtocol = URLSessionDataSource()) {
    self.dataSource = dataSource
  }

  public func getShifts(for date: Date?) async -> ShiftsModel? {
    do {
      let response: ShiftsResponse = try await dataSource.fetch(request: TemperRequest.shifts(date: date))
      return response
    } catch {
      return nil
    }
  }
}
