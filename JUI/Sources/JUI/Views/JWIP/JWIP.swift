//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI

public struct JWIP: View {
  let title: String
  let buttonText: String?
  let buttonAction: JButtonAction?

  private let iconSize: CGFloat = 70

  public init(
    title: String,
    buttonText: String? = nil,
    buttonAction: JButtonAction? = nil
  ) {
    self.title = title
    self.buttonText = buttonText
    self.buttonAction = buttonAction

  }

  public var body: some View {
    VStack(spacing: DesignSystem.Spacings.standard) {
      Image(DesignSystem.Icons.workers, bundle: .module)
        .resizable()
        .frame(width: iconSize, height: iconSize)

      Text(title)
        .font(DesignSystem.Fonts.title)
        .foregroundColor(DesignSystem.Colors.title)

      Text("This feature is under construction. Soon you'll enjoy it :)")
        .multilineTextAlignment(.center)
        .font(DesignSystem.Fonts.description)
        .foregroundColor(DesignSystem.Colors.description)
        .padding(.horizontal, DesignSystem.Spacings.medium)

      if let buttonAction, let buttonText {
        JButton(text: buttonText, type: .secondary, action: buttonAction)
          .frame(width: 100, height: 40)
          .padding(.top, DesignSystem.Spacings.medium)
      }
    }
    .frame(alignment: .center)
  }
}

struct JWIP_Previews: PreviewProvider {
  static var previews: some View {
    JWIP(title: "Feature", buttonText: "Action") {}
  }
}
