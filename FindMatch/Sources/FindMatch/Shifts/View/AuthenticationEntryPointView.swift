//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI
import JUI

struct AuthenticationEntryPointView: View {
  var signUpAction: JButtonAction
  var loginAction: JButtonAction

  var body: some View {
    HStack(spacing: DesignSystem.Spacings.medium) {
      JButton(
        text: "Sign up",
        type: .primary,
        action: signUpAction
      )

      JButton(
        text: "Log in",
        type: .secondary,
        action: loginAction
      )
    }
    .padding(.horizontal, DesignSystem.Spacings.xxs)
    .frame(height: 45)
    .padding(.vertical, DesignSystem.Spacings.small)
    .background(DesignSystem.Colors.background)
  }
}

struct AuthenticationEntryPointView_Previews: PreviewProvider {
  static var previews: some View {
    AuthenticationEntryPointView(
      signUpAction: {},
      loginAction: {}
    )
  }
}
