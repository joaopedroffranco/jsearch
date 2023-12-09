//
//  Created by João Pedro Fabiano Franco
//

import UIKit
import SwiftUI

public class FiltersViewController: UIHostingController<FiltersScreen> {
  public init() {
    let filtersScreen = FiltersScreen()
    super.init(rootView: filtersScreen)
    navigationItem.title = "Filters"
  }

  @MainActor required dynamic init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
