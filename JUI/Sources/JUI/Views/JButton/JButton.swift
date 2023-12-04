//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI

public typealias JButtonAction = () -> Void

public struct JButton: View {
  let text: String
  let type: JButtonType
  let action: JButtonAction?

  public init(
    text: String,
    type: JButtonType,
    action: JButtonAction? = nil
  ) {
    self.text = text
    self.type = type
    self.action = action
  }

  public var body: some View {
    buttonView
      .onTapGesture { action?() }
  }

  private var buttonView: some View {
    ZStack {
      Text(text)
        .font(DesignSystem.Fonts.button)
        .foregroundColor(type.fontColor)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(type.backgroundColor)
    .overlay(
      RoundedRectangle(
        cornerRadius: type.cornerRadius
      )
      .stroke(
        type.borderColor,
        lineWidth: type.borderWidth
      )
    )
  }
}

struct JButton_Previews: PreviewProvider {
  static var previews: some View {
    HStack(spacing: 8) {
      JButton(text: "Primary Button", type: .primary)

      JButton(text: "Secondary Button", type: .secondary)
    }
    .padding(.horizontal)
    .frame(height: 50)
  }
}
