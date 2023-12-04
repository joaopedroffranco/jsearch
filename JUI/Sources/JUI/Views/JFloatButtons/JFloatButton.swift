//
//  Created by João Pedro Fabiano Franco
//

import Foundation

public struct JFloatButton {
  let icon: String?
  let text: String
  let action: JButtonAction?

  let bundle: Bundle

  public init(
    icon: String? = nil,
    text: String,
    action: JButtonAction? = nil,
    bundle: Bundle = .main
  ) {
    self.icon = icon
    self.text = text
    self.action = action
    self.bundle = bundle
  }
}
