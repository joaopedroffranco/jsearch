//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import JFoundation

public class URLSessionDataSource: RemoteDataSourceProtocol {
  let session: URLSession
  let logger: LoggerProtocol

  public init(session: URLSession = .shared, logger: LoggerProtocol = Logger()) {
    self.session = session
    self.logger = logger
  }

  public func fetch<T>(request: Requestable) async throws -> T where T: Decodable {
    guard let request = request.request else {
      throw RemoteError.invalidRequest
    }

    let (data, _) = try await session.data(for: request)
    let decoder = JSONDecoder()

    do {
      return try decoder.decode(T.self, from: data)
    } catch {
      logger.log(topic: "Data Source", message: error.localizedDescription)
      throw RemoteError.decodeError
    }
  }

  public func post(request: Requestable) async throws {
    guard let request = request.request else {
      throw RemoteError.invalidRequest
    }

    do {
      let (data, _) = try await session.data(for: request)
      if data.isEmpty { throw RemoteError.requestFailed }
    } catch {
      logger.log(topic: "Data Source", message: error.localizedDescription)
      throw RemoteError.requestFailed
    }
  }
}
