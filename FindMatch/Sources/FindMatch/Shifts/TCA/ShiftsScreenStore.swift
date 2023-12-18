//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI
import JUI
import ComposableArchitecture

public struct ShiftsScreenStore: View {
  let store: StoreOf<ShiftsFeature>

  public init(store: StoreOf<ShiftsFeature>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      mainView(viewStore)
        .onLoad { viewStore.send(.getTodayShifts(isPullToRefresh: false)) }
        .refreshable { store.send(.getTodayShifts(isPullToRefresh: true)) }
    }
  }

  @ViewBuilder
  private func mainView(
    _ viewStore: ViewStoreOf<ShiftsFeature>
  ) -> some View {
    switch viewStore.viewState {
    case .initial:
      ProgressView("Loading shifts...")
        .progressViewStyle(CircularProgressViewStyle())
        .padding()
    case .loading:
      ProgressView("Loading shifts...")
        .progressViewStyle(CircularProgressViewStyle())
        .padding()
    case .error:
      JError(message: "We couldn't fetch the shifts for today.") {
        viewStore.send(.getFollowingShifts)
      }
    case let .loaded(viewModels):
      ZStack(alignment: .bottom) {
        ShiftListView(viewModels: viewModels) { sectionIndex, itemIndex in
          viewStore.send(.itemDidAppear(section: sectionIndex, index: itemIndex))
        }

        VStack(spacing: DesignSystem.Spacings.medium) {
          JFloatButtons(buttons: [
            JFloatButton(
              icon: DesignSystem.Icons.filter,
              text: "Filters",
              action: { viewStore.send(.goFilters) }
            ),
            JFloatButton(
              icon: DesignSystem.Icons.map,
              text: "Kaart",
              action: { viewStore.send(.goKaart) }
            )
          ])

          AuthenticationEntryPointView(
            signUpAction: { viewStore.send(.goSignUp) },
            loginAction: { viewStore.send(.goLogin) }
          )
        }
      }
      .background(DesignSystem.Colors.background)
    }
  }
}

struct ShiftsScreenStore_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ShiftsScreenStore(store: Store(initialState: ShiftsFeature.State()) { ShiftsFeature() })
    }
  }
}
