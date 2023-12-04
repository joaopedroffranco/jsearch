//
//  Created by João Pedro Fabiano Franco
//

import Foundation

public protocol RepositoryProtocol: AnyObject {
  func fetch<T: Decodable>(request: Requestable) async throws -> T
  func post(request: Requestable) async throws
}
