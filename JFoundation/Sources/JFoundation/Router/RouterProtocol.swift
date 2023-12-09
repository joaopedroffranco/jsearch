//
//  RouterProtocol.swift
//  JJFoundationKit
//
//  Created by João Pedro Fabiano Franco on 18.11.23.
//

import UIKit

public protocol RouterProtocol: RouterDelegate {
  /// weak reference
  var parentRouter: RouterProtocol? { get set }
  var nextRouter: RouterProtocol? { get set }

  func start()
  func childRouterDidDismiss()
}

public extension RouterProtocol {
  func clean() {
    parentRouter?.childRouterDidDismiss()
    parentRouter = nil
    nextRouter = nil
  }

  func childRouterDidDismiss() {
    nextRouter = nil
  }
}
