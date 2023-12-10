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
  public var didPost: Bool = false

  init(jsonFile: JSONFileProtocol) {
    self.jsonFile = jsonFile
  }

  public func fetch<T>(request: Requestable, dataType: T.Type) -> Future<T, RemoteError> where T : Decodable {
    Future { promise in
      guard
        let data = self.get(file: self.jsonFile),
        let response = try? JSONDecoder().decode(dataType.self, from: data)
      else {
        promise(.failure(RemoteError.invalidRequest))
        return
      }

      promise(.success(response))
    }
  }

  public func post(request: Requestable) async throws {
    didPost = true
  }

  private func get(file: JSONFileProtocol) -> Data? {
    let bundle = Bundle.module
    guard let url = bundle.url(
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


