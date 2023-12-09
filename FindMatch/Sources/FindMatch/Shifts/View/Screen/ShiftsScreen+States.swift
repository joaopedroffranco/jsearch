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
    JError(message: "We couldn't fetch the shifts for today.") {
      screenViewModel.getTodayShifts()
    }
  }

  func loadedView(viewModels: [ShiftsViewModel]) -> some View {
    ZStack(alignment: .bottom) {
      ShiftListView(viewModels: viewModels) { sectionIndex, itemIndex in
        screenViewModel.getFollowingShiftsIfNeeded(section: sectionIndex, index: itemIndex)
      }

      VStack(spacing: DesignSystem.Spacings.medium) {
        JFloatButtons(buttons: [
          JFloatButton(
            icon: DesignSystem.Icons.filter,
            text: "Filters",
            action: screenViewModel.goFilters
          ),
          JFloatButton(
            icon: DesignSystem.Icons.map,
            text: "Kaart",
            action: screenViewModel.goKaart
          )
        ])

        AuthenticationEntryPointView(
          signUpAction: screenViewModel.goLogin,
          loginAction: screenViewModel.goSingUp
        )
      }
    }
    .background(DesignSystem.Colors.background)
  }
}
