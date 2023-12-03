//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI

enum JButtonType {
  case primary
  case secondary

  var backgroundColor: Color {
    switch self {
    case .primary: return DesignSystem.Colors.primary
    case .secondary: return DesignSystem.Colors.white
    }
  }

  var borderColor: Color {
    switch self {
    case .primary: return DesignSystem.Colors.primary
    case .secondary: return DesignSystem.Colors.secondary
    }
  }

  var font: Font {
    DesignSystem.Fonts.button
  }

  var fontColor: Color {
    DesignSystem.Colors.secondary
  }
}
