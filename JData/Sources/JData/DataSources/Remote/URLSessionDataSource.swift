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

  public func fetch<T>(request: Requestable, dataType: T.Type) -> AnyPublisher<T, RemoteError> where T : Decodable {
    let subject = PassthroughSubject<T, RemoteError>()
    guard let request = request.request else {
      subject.send(completion: .failure(.invalidRequest))
      return subject.eraseToAnyPublisher()
    }

    cancellable = session
      .dataTaskPublisher(for: request)
      .map(\.data)
      .decode(type: dataType, decoder: decoder)
      .sink(
        receiveCompletion: { completion in
          switch completion {
          case .failure: subject.send(completion: .failure(.requestFailed))
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
