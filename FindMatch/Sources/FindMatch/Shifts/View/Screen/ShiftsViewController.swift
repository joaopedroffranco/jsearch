//
//  Created by João Pedro Fabiano Franco
//

import UIKit
import SwiftUI
import ComposableArchitecture
import JData

public class ShiftsViewController: UIHostingController<ShiftsScreen> {
  public init(viewModel: ShiftsScreenViewModel = ShiftsScreenViewModel()) {
    let shiftsScreen = ShiftsScreen(screenViewModel: viewModel)
    super.init(rootView: shiftsScreen)
    navigationItem.title = "Jobs"
  }

  @MainActor required dynamic init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

public class ShiftsStoreViewController: UIHostingController<ShiftsScreenStore> {
  public init(feature: ShiftsFeature = ShiftsFeature()) {
    let store = Store(
      initialState: ShiftsFeature.State()) {
        feature
      } withDependencies: { dependencies in
        dependencies.shiftsRepository = ShiftsRepository()
      }

    let shiftsScreen = ShiftsScreenStore(store: store)
    super.init(rootView: shiftsScreen)
    navigationItem.title = "Jobs"
  }

  @MainActor required dynamic init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
