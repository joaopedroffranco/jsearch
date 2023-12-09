//
//  Created by João Pedro Fabiano Franco
//

import UIKit
import SwiftUI

public class KaartViewController: UIHostingController<KaartScreen> {
  public init() {
    let kaartScreen = KaartScreen()
    super.init(rootView: kaartScreen)
    navigationItem.title = "Kaart"
  }

  @MainActor required dynamic init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
