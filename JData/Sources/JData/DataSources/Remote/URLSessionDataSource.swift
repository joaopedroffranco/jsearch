//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import Combine
import JFoundation

public class URLSessionDataSource: RemoteDataSourceProtocol {
  let session: URLSession
  let decoder: JSONDecoder
  let logger: LoggerProtocol

  public init(
    session: URLSession = .shared,
    logger: LoggerProtocol = Logger(),
    decoder: JSONDecoder = JSONDecoder()
  ) {
    self.session = session
    self.logger = logger
    self.decoder = decoder
  }

  public func fetch<T>(request: Requestable, dataType: T.Type) -> RemotePublisher<T> where T: Decodable {
    guard let request = request.request else {
      logger.log(topic: "URL Session", message: "Invalid request")
      return Fail<T, RemoteError>(error: RemoteError.invalidRequest).eraseToAnyPublisher()
    }

    return session
      .dataTaskPublisher(for: request)
      .map(\.data)
      .decode(type: dataType, decoder: decoder)
      .map { $0 }
      .mapError { _ in
        self.logger.log(topic: "URL Session", message: "Couldn't decode the response")
        return RemoteError.invalidRequest
      }
      .eraseToAnyPublisher()
  }

  public func fetch<T>(request: Requestable) async throws -> T where T : Decodable {
    guard let request = request.request else {
      logger.log(topic: "URL Session", message: "Invalid request")
      throw RemoteError.invalidRequest
    }

    do {
      let (response, _) = try await session.data(for: request)
      return try decoder.decode(T.self, from: response)
    } catch {
      logger.log(topic: "URL Session", message: "Couldn't decode the response")
      throw RemoteError.decodeError
    }
  }
}
