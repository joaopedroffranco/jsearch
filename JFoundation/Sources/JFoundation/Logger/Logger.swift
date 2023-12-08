//
//  Created by João Pedro Fabiano Franco
//

import Foundation

public protocol LoggerProtocol {
  func log(topic: String, message: String)
}

public class Logger: LoggerProtocol {
  public init() {}

  public func log(topic: String, message: String) {
    print("[\(topic)]", message)
  }
}
