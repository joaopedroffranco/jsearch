//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI
import JUI

public struct FiltersScreen: View {
  public var body: some View {
    JWIP(title: "Filters")
      .background(DesignSystem.Colors.background)
  }
}

struct FiltersScreen_Previews: PreviewProvider {
  static var previews: some View {
    FiltersScreen()
  }
}
