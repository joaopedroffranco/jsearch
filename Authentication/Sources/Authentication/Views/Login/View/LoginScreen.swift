//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI
import JUI

public struct LoginScreen: View {
  public var body: some View {
    JWIP(title: "Login")
      .background(DesignSystem.Colors.background)
  }
}

struct LoginScreen_Previews: PreviewProvider {
  static var previews: some View {
    LoginScreen()
  }
}
