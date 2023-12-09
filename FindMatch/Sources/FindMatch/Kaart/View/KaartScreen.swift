//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI
import JUI

struct KaartScreen: View {
  var body: some View {
    JWIP(title: "Kaart")
      .background(DesignSystem.Colors.background)
  }
}

struct KaartScreen_Previews: PreviewProvider {
  static var previews: some View {
    KaartScreen()
  }
}
