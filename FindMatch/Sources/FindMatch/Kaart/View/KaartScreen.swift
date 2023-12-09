//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI
import JUI

public struct KaartScreen: View {
  public var body: some View {
    JWIP(title: "Kaart")
      .background(DesignSystem.Colors.background)
  }
}

struct KaartScreen_Previews: PreviewProvider {
  static var previews: some View {
    KaartScreen()
  }
}
