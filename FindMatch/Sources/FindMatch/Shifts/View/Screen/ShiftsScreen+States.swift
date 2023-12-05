//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI
import JData
import JUI

extension ShiftsScreen {
  var initialView: some View {
    Text("Initial State")
      .padding()
  }

  var loadingView: some View {
    ProgressView("Loading shifts...")
      .progressViewStyle(CircularProgressViewStyle())
      .padding()
  }

  var errorView: some View {
    Text("Error on getting shifts")
      .padding()
  }

  func loadedView(viewModel: ShiftsViewModel) -> some View {
    ZStack(alignment: .bottom) {
      ShiftListView(viewModel: viewModel)

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
