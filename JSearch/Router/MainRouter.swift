//
//  Created by João Pedro Fabiano Franco
//

import UIKit
import FindMatch
import JFoundation

class MainRouter: RouterProtocol {
  weak var parentRouter: RouterDelegate?
  let navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let router = FindMatchRouter(parentRouter: self, navigationController: navigationController)
    router.start()
  }
}

extension MainRouter: RouterDelegate {
  func onDismiss() {}
}
