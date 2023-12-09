//
//  Created by João Pedro Fabiano Franco
//

import UIKit
import SwiftUI
import JFoundation

public class LoginViewController: UIHostingController<LoginScreen> {
  weak var routerDelegate: AuthenticationRouterDelegate?

  public init(routerDelegate: AuthenticationRouterDelegate) {
    let loginScreen = LoginScreen()
    super.init(rootView: loginScreen)
    self.routerDelegate = routerDelegate
  }

  @MainActor required dynamic init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    routerDelegate?.dismiss()
  }
}
