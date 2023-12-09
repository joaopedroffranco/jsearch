//
//  Created by João Pedro Fabiano Franco
//

import UIKit
import SwiftUI
import JFoundation

public class FindMatchRouter: RouterProtocol {
  public weak var parentRouter: RouterDelegate?
  public var nextRouter: RouterProtocol?

  let navigationController: UINavigationController

  public init(parentRouter: RouterDelegate?, navigationController: UINavigationController) {
    self.parentRouter = parentRouter
    self.navigationController = navigationController
  }

  public func start() {
    let viewController = makeShiftsScreenViewController()
    navigationController.setViewControllers([viewController], animated: false)
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

  func goLogin() {}

  func goSignUp() {}

  public func dismiss() {
    navigationController.topViewController?.dismiss(animated: true)
    nextRouter = nil
    parentRouter = nil
  }
}

private extension FindMatchRouter {
  func makeShiftsScreenViewController() -> UIViewController {
    let viewModel = ShiftsScreenViewModel()
    viewModel.parentRouter = self

    let viewController = ShiftsViewController(viewModel: viewModel)
    return viewController
  }

  func makeFiltersScreenViewController() -> UIViewController {
    FiltersViewController()
  }

  func makeKaartScreenViewController() -> UIViewController {
    KaartViewController()
  }
}
