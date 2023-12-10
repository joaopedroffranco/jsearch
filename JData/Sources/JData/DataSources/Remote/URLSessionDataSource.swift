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

  private var cancellable: AnyCancellable?

  public init(
    session: URLSession = .shared,
    logger: LoggerProtocol = Logger(),
    decoder: JSONDecoder = JSONDecoder()
  ) {
    self.session = session
    self.logger = logger
    self.decoder = decoder
  }

  public func fetch<T>(request: Requestable, dataType: T.Type) -> Future<T, RemoteError> where T: Decodable {
    Future { promise in
      guard let request = request.request else {
        promise(.failure(RemoteError.invalidRequest))
        return
      }

      self.cancellable = self.session
        .dataTaskPublisher(for: request)
        .map(\.data)
        .decode(type: dataType, decoder: self.decoder)
        .sink(
          receiveCompletion: { completion in
            switch completion {
            case .failure: promise(.failure(RemoteError.requestFailed))
            default: break
            }
          },
          receiveValue: { decodable in
            promise(.success(decodable))
          }
        )
    }
  }
}
