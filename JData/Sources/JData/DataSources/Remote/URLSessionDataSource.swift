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

  public func fetch<T>(request: Requestable, dataType: T.Type) -> RemotePublisher<T> where T: Decodable {
    let subject = PassthroughSubject<T, RemoteError>()
    guard let request = request.request else {
      logger.log(topic: "URL Session", message: "Invalid request")
      return Fail<T, RemoteError>(error: RemoteError.invalidRequest).eraseToAnyPublisher()
    }

    cancellable = session
      .dataTaskPublisher(for: request)
      .map(\.data)
      .decode(type: dataType, decoder: self.decoder)
      .sink(
        receiveCompletion: { completion in
          switch completion {
          case .failure:
            self.logger.log(topic: "URL Session", message: "Couldn't decode the response")
            return subject.send(completion: .failure(.invalidRequest))
          default: break
          }
        },
        receiveValue: { decodable in
          subject.send(decodable)
        }
      )

    return subject.eraseToAnyPublisher()
  }
}
