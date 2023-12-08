//
//  Created by João Pedro Fabiano Franco
//

import UIKit
import JFoundation

public class FindMatchRouter: RouterProtocol {
  public weak var parentRouter: RouterDelegate?

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

private extension FindMatchRouter {
  func makeShiftsScreenViewController() -> UIViewController {
    let viewController = UIViewController()
    viewController.view.backgroundColor = .blue
    return viewController
  }
}
