//
//  Created by João Pedro Fabiano Franco
//

import UIKit
import FindMatch
import JFoundation

class MainRouter: RouterProtocol {
  weak var parentRouter: RouterDelegate?
  var nextRouter: RouterProtocol?
  let navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    nextRouter = FindMatchRouter(parentRouter: self, navigationController: navigationController)
    nextRouter?.start()
  }
}

extension MainRouter: RouterDelegate {
  func dismiss() {}
}
