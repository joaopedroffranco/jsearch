//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import Combine

public typealias RemotePublisher<T: Decodable> = AnyPublisher<T, RemoteError>

public protocol RemoteDataSourceProtocol: AnyObject {
  func fetch<T: Decodable>(request: Requestable, dataType: T.Type) -> RemotePublisher<T>

  func fetch<T: Decodable>(request: Requestable) async throws -> T
}
