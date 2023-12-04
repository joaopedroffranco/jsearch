//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI

public struct JFloatButtons: View {
  let buttons: [JFloatButton]

  private let iconSize: CGFloat = 14.0
  private let height: CGFloat = 30
  private let verticalPadding = DesignSystem.Spacings.xs
  private var radius: CGFloat {
    (height / 2) + 2 * verticalPadding
  }

  public init(buttons: [JFloatButton]) {
    self.buttons = buttons
  }

  public var body: some View {
    HStack {
      ForEach(Array(buttons.enumerated()), id: \.offset) {
        if $0.offset != 0 {
          Rectangle()
            .frame(width: 1.5)
            .foregroundColor(DesignSystem.Colors.separator)
        }

        button(from: buttons[$0.offset])
      }
    }
    .frame(height: height)
    .padding(.horizontal, DesignSystem.Spacings.small)
    .padding(.vertical, verticalPadding)
    .background(DesignSystem.Colors.background)
    .cornerRadius(radius)
    .shadow(
      color: DesignSystem.Colors.shadow,
      radius: DesignSystem.Radius.shadow
    )
  }

  @ViewBuilder
  private func button(from button: JFloatButton) -> some View {
    HStack(spacing: DesignSystem.Spacings.xxs) {
      if let icon = button.icon {
        Image(icon, bundle: button.bundle)
          .resizable()
          .frame(width: iconSize, height: iconSize)
          .foregroundColor(DesignSystem.Colors.secondary)
      }

      Text(button.text)
        .font(DesignSystem.Fonts.button)
        .foregroundColor(DesignSystem.Colors.secondary)
    }
    .onTapGesture { button.action?() }
  }
}

struct JFloatButtons_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 50) {
      JFloatButtons(buttons: [
        JFloatButton(icon: "filter", text: "Filters", bundle: .module),
      ])

      JFloatButtons(buttons: [
        JFloatButton(icon: "filter", text: "Filters", bundle: .module),
        JFloatButton(icon: "map", text: "Kaart", bundle: .module)
      ])

      JFloatButtons(buttons: [
        JFloatButton(icon: "filter", text: "Filters", bundle: .module),
        JFloatButton(icon: "map", text: "Kaart", bundle: .module),
        JFloatButton(text: "Another", bundle: .module)
      ])
    }
    .frame(maxWidth: .infinity)
    .frame(height: 100)
  }
}
