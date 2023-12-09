//
//  Created by João Pedro Fabiano Franco
//
    

import SwiftUI

public struct JError: View {
  var message: String
  var tryAgainAction: JButtonAction?

  private let iconSize: CGFloat = 50

  public init(message: String, tryAgainAction: JButtonAction? = nil) {
    self.message = message
    self.tryAgainAction = tryAgainAction
  }

  public var body: some View {
    VStack(spacing: DesignSystem.Spacings.standard) {
      Image(DesignSystem.Icons.warning, bundle: .module)
        .resizable()
        .frame(width: iconSize, height: iconSize)

      Text(message)
        .multilineTextAlignment(.center)
        .font(DesignSystem.Fonts.title)
        .foregroundColor(DesignSystem.Colors.description)
        .padding(.horizontal, DesignSystem.Spacings.medium)

      JButton(text: "Try again", type: .secondary, action: tryAgainAction)
        .frame(width: 100, height: 40)
        .padding(.top, DesignSystem.Spacings.medium)
    }
    .frame(alignment: .center)
  }
}

struct JError_Previews: PreviewProvider {
  static var previews: some View {
    JError(message: "There is error here :(")
  }
}
