//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI
import UIKit

/// Specific colors
extension Color {
  static let jBlack = Color(red: 13/255, green: 3/255, blue: 25/255)
  static let jDarkGray = Color(red: 75/255, green: 65/255, blue: 84/255)
  static let jGray = Color(red: 195/255, green: 195/255, blue: 195/255)
  static let jPurple = Color(red: 105/255, green: 50/255, blue: 223/255)
  static let jGreen = Color(red: 0/255, green: 255/255, blue: 135/255)
}

public extension Color {
  var uiColor: UIColor { UIColor(self) }
}
