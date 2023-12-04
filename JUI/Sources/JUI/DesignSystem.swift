//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI

public enum DesignSystem {
  public enum Colors {
    public static let header = Color.jBlack
    public static let title = Color.jBlack
    public static let info = Color.jPurple
    public static let description = Color.jDarkGray
    public static let primary = Color.jGreen
    public static let secondary = Color.jBlack
    public static let background = Color.white
    public static let separator = Color.jGray
    public static let shadow = Color.jBlack.opacity(0.25)
  }

  public enum Fonts {
    public static let title = Font.system(size: 16).bold()
    public static let info = Font.system(size: 12).bold()
    public static let description = Font.system(size: 16)
    public static let price = Font.system(size: 16).bold()
    public static let header = Font.system(size: 20)
    public static let button = Font.system(size: 16).bold()
  }

  public enum Borders {
    public static let small = 1.0
    public static let medium = 2.0
    public static let large = 4.0
  }

  public enum Radius {
    public static let small: CGFloat = 2.0
    public static let medium: CGFloat = 4.0
    public static let large: CGFloat = 6.0
    public static let shadow: CGFloat = 6.0
  }

  public enum Spacings {
    public static let large = 48.0
    public static let medium = 24.0
    public static let small = 16.0
    public static let standard = 12.0
    public static let xs = 8.0
    public static let xxs = 6.0
    public static let xxxs = 4.0
    public static let xxxxs = 2.0
  }
}
