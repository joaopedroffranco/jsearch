//
//  Created by João Pedro Fabiano Franco
//

import UIKit
import FindMatch
import JUI
import JFoundation

class MainRouter: RouterProtocol {
  weak var parentRouter: RouterProtocol?
  var nextRouter: RouterProtocol?
  let navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController

    let backgroundColor = DesignSystem.Colors.background.uiColor
    self.navigationController.navigationBar.backgroundColor = backgroundColor
    self.navigationController.navigationBar.barTintColor = backgroundColor
    self.navigationController.navigationBar.shadowImage = UIImage()
  }

  func start() {
    nextRouter = FindMatchRouter(parentRouter: self, navigationController: navigationController)
    nextRouter?.start()
  }

  func dismiss() {}
}
