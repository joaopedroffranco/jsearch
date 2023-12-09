//
//  Created by João Pedro Fabiano Franco
//

import UIKit
import JFoundation
import Authentication

public enum AuthenticationRouterDataSource {
  case login
  case signup
}

public class AuthenticationRouter: RouterProtocol {
  public weak var parentRouter: RouterProtocol?
  public var nextRouter: RouterProtocol?

  let navigationController: UINavigationController
  let dataSource: AuthenticationRouterDataSource

  public init(
    dataSource: AuthenticationRouterDataSource,
    parentRouter: RouterProtocol?,
    navigationController: UINavigationController
  ) {
    self.dataSource = dataSource
    self.parentRouter = parentRouter
    self.navigationController = navigationController
  }

  public func start() {
    let viewController = makeInitialViewController()
    navigationController.topViewController?.present(viewController, animated: true)
  }

  deinit {
    clean()
  }
}

extension AuthenticationRouter: AuthenticationRouterDelegate {
  public func dismiss() {
    clean()
  }
}

private extension AuthenticationRouter {
  func makeInitialViewController() -> UIViewController {
    switch dataSource {
    case .login: return makeLoginViewController()
    case .signup: return makeSignUpViewController()
    }
  }

  func makeLoginViewController() -> UIViewController {
    LoginViewController(routerDelegate: self)
  }

  func makeSignUpViewController() -> UIViewController {
    SignUpViewController(routerDelegate: self)
  }
}
