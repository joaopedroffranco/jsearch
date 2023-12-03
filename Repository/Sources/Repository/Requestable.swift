//
//  Created by João Pedro Fabiano Franco
//

import Foundation

public enum RequestMethod: String {
  case get = "GET"
  case post = "POST"
}

public protocol Requestable {
  var method: RequestMethod { get }
  var host: String { get }
  var endpoint: String { get }
  var params: [String: String]? { get }
  var headers: [String: String]? { get }
  var cachePolicy: URLRequest.CachePolicy { get }
  var request: URLRequest? { get }
}

public extension Requestable {
  var request: URLRequest? {
    switch method {
    case .get: return getRequest
    case .post: return postRequest
    }
  }

  private var urlString: String { host + endpoint }

  private var getRequest: URLRequest? {
    var urlComponents = URLComponents(string: urlString)
    urlComponents?.queryItems = params?.map {
      URLQueryItem(name: $0.key, value: $0.value)
    }

    guard
      let string = urlComponents?.string,
      let url = URL(string: string)
    else {
      return nil
    }

    var request = URLRequest(url: url, cachePolicy: cachePolicy)
    headers?.forEach {
      request.setValue($0.key, forHTTPHeaderField: $0.value)
    }

    return request
  }

  private var postRequest: URLRequest? {
    guard let url = URL(string: urlString) else { return nil }

    var request = URLRequest(url: url, cachePolicy: cachePolicy)
    headers?.forEach {
      request.setValue($0.key, forHTTPHeaderField: $0.value)
    }
    request.httpMethod = "POST"

    if let params {
      request.httpBody = try? JSONSerialization.data(
        withJSONObject: params
      )
    }

    return request
  }
}
