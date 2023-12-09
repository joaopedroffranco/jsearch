//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI

struct ViewDidLoadModifier: ViewModifier {
  @State private var viewDidLoad = false
  let action: (() -> Void)?

  func body(content: Content) -> some View {
    content
      .onAppear {
        if viewDidLoad == false {
          viewDidLoad = true
          action?()
        }
      }
  }
}

public extension View {
  func onLoad(perform action: (() -> Void)? = nil) -> some View {
    self.modifier(ViewDidLoadModifier(action: action))
  }
}
