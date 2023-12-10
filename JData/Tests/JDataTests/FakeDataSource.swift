//
//  Created by João Pedro Fabiano Franco
//

import UIKit
import Combine
@testable import JData

public protocol JSONFileProtocol {
  var name: String { get }
}

public class FakeDataSource: RemoteDataSourceProtocol {
  let jsonFile: JSONFileProtocol

  init(jsonFile: JSONFileProtocol) {
    self.jsonFile = jsonFile
  }

  public func fetch<T>(request: Requestable, dataType: T.Type) -> RemotePublisher<T> where T: Decodable {
    guard
      let data = get(file: self.jsonFile),
      let response = try? JSONDecoder().decode(dataType.self, from: data)
    else {
      return Fail(error: RemoteError.invalidRequest).eraseToAnyPublisher()
    }

    return Just(response).setFailureType(to: RemoteError.self).eraseToAnyPublisher()
  }

  private func get(file: JSONFileProtocol) -> Data? {
    guard let url = Bundle.module.url(
      forResource: file.name,
      withExtension: "json"
    ) else {
      return nil
    }

    do {
      let data = try Data(contentsOf: url)
      return data
    } catch {
      return nil
    }
  }
}


