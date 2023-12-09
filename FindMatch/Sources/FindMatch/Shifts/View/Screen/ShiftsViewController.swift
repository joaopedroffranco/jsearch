//
//  Created by João Pedro Fabiano Franco
//

import UIKit
import SwiftUI

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
