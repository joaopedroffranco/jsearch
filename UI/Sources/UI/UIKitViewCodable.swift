//
//  Created by João Pedro Fabiano Franco
//

public protocol UIKitViewCodable {
  func buildViewHierarchy()
  func setupConstraints()
  func configureViews()
  func setupView()
}

public extension UIKitViewCodable {
  func setupView() {
    buildViewHierarchy()
    setupConstraints()
    configureViews()
  }
}
