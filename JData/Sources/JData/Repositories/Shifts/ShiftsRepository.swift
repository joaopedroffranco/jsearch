//
//  Created by João Pedro Fabiano Franco
//

import Foundation

public protocol ShiftsRepositoryProtocol: AnyObject {
  func getShifts() async -> ShiftsModel?
}

public class ShiftsRepository: ShiftsRepositoryProtocol {
  var dataSource: DataSourceProtocol

  init(dataSource: DataSourceProtocol = RemoteDataSource()) {
    self.dataSource = dataSource
  }

  public func getShifts() async -> ShiftsModel? {
    return nil
  }
}
