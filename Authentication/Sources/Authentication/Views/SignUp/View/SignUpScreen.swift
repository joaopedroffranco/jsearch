//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI
import JUI

public struct SignUpScreen: View {
  public var body: some View {
    JWIP(title: "Sign Up")
      .background(DesignSystem.Colors.background)
  }
}

struct SignUpScreen_Previews: PreviewProvider {
  static var previews: some View {
    SignUpScreen()
  }
}
