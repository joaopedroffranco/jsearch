//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI

public struct JWIP: View {
  let title: String

  private let iconSize: CGFloat = 70

  public init(title: String) {
    self.title = title
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
    }
    .frame(alignment: .center)
  }
}

struct JWIP_Previews: PreviewProvider {
  static var previews: some View {
    JWIP(title: "Filter")
  }
}
