//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import Combine

public protocol RemoteDataSourceProtocol: AnyObject {
  func fetch<T: Decodable>(request: Requestable, dataType: T.Type) -> AnyPublisher<T, RemoteError>
}
