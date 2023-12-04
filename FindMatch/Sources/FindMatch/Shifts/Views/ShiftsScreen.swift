//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI
import JUI

struct ShiftsScreen: View {
  var body: some View {
    ZStack(alignment: .bottom) {
      ShiftListView()

      VStack(spacing: DesignSystem.Spacings.medium) {
        JFloatButtons(buttons: [
          JFloatButton(
            icon: DesignSystem.Icons.filter,
            text: "Filters",
            action: nil
          ),
          JFloatButton(
            icon: DesignSystem.Icons.map,
            text: "Kaart",
            action: nil
          )
        ])

        AuthenticationEntryPointView(
          signUpAction: {},
          loginAction: {}
        )
      }
    }
    .background(DesignSystem.Colors.background)
  }
}

struct ShiftsScreen_Previews: PreviewProvider {
  static var previews: some View {
    ShiftsScreen()
  }
}
