//
//  Created by João Pedro Fabiano Franco
//

import UIKit
@testable import JData

public enum FakeRemoteError: Error {
  case invalidResponse
}

public protocol JSONFileProtocol {
  var name: String { get }
}

public class FakeDataSource: DataSourceProtocol {
  let jsonFile: JSONFileProtocol
  public var didPost: Bool = false

  init(jsonFile: JSONFileProtocol) {
    self.jsonFile = jsonFile
  }

  public func fetch<T: Decodable>(request: Requestable) async throws -> T {
    guard
      let data = get(file: jsonFile),
      let response = try? JSONDecoder().decode(T.self, from: data)
    else {
      throw FakeRemoteError.invalidResponse
    }

    return response
  }

  public func post(request: Requestable) async throws {
    didPost = true
  }

  private func get(file: JSONFileProtocol) -> Data? {
    let bundle = Bundle(for: type(of: self))
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


