//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI
import JUI

struct FiltersScreen: View {
  var body: some View {
    JWIP(title: "Filters")
      .background(DesignSystem.Colors.background)
  }
}

struct FiltersScreen_Previews: PreviewProvider {
  static var previews: some View {
    FiltersScreen()
  }
}
