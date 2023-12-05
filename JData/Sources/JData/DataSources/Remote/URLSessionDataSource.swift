//
//  Created by João Pedro Fabiano Franco
//

import Foundation

public class URLSessionDataSource: RemoteDataSourceProtocol {
  let session: URLSession

  public init(session: URLSession = .shared) {
    self.session = session
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
      throw RemoteError.requestFailed
    }
  }
}
