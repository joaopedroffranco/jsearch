//
//  Created by João Pedro Fabiano Franco
//

import UIKit
import SwiftUI

public class SignUpViewController: UIHostingController<SignUpScreen> {
  weak var routerDelegate: AuthenticationRouterDelegate?

  public init(routerDelegate: AuthenticationRouterDelegate) {
    let signUpScreen = SignUpScreen()
    super.init(rootView: signUpScreen)
    self.routerDelegate = routerDelegate
  }

  @MainActor required dynamic init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    routerDelegate?.dismiss()
  }
}
