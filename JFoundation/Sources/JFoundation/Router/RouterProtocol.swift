//
//  RouterProtocol.swift
//  JJFoundationKit
//
//  Created by João Pedro Fabiano Franco on 18.11.23.
//

import UIKit

public protocol RouterProtocol: AnyObject {
  /// weak reference
  var parentRouter: RouterDelegate? { get }
  var nextRouter: RouterProtocol? { get }

  func start()
}
