//
//  Created by João Pedro Fabiano Franco
//

import UIKit
import SwiftUI
import JFoundation
import FindMatch

class FindMatchRouter: RouterProtocol {
  public weak var parentRouter: RouterProtocol?
  public var nextRouter: RouterProtocol?

  let navigationController: UINavigationController

  init(parentRouter: RouterProtocol?, navigationController: UINavigationController) {
    self.parentRouter = parentRouter
    self.navigationController = navigationController
  }

  func start() {
    let viewController = makeShiftsScreenViewController()
    navigationController.setViewControllers([viewController], animated: false)
  }

  deinit {
    clean()
  }
}

extension FindMatchRouter: FindMatchRouterDelegate {
  func goFilters() {
    let viewController = makeFiltersScreenViewController()
    navigationController.pushViewController(viewController, animated: true)
  }

  func goKaart() {
    let viewController = makeKaartScreenViewController()
    navigationController.pushViewController(viewController, animated: true)
  }

  func goLogin() {
    nextRouter = AuthenticationRouter(
      dataSource: .login,
      parentRouter: self,
      navigationController: navigationController
    )
    nextRouter?.start()
  }

  func goSignUp() {
    nextRouter = AuthenticationRouter(
      dataSource: .signup,
      parentRouter: self,
      navigationController: navigationController
    )
    nextRouter?.start()
  }

  func dismiss() {
    navigationController.topViewController?.dismiss(animated: true)
    parentRouter = nil
  }
}

private extension FindMatchRouter {
  func makeShiftsScreenViewController() -> UIViewController {
    let shiftsFeature = ShiftsFeature()

    let viewController = ShiftsStoreViewController(feature: shiftsFeature)
    return viewController
  }

  func makeFiltersScreenViewController() -> UIViewController {
    FiltersViewController()
  }

  func makeKaartScreenViewController() -> UIViewController {
    KaartViewController()
  }
}
