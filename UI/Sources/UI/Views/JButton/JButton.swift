//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI

struct JButton: View {
  var text: String
  var type: JButtonType

  init(text: String, type: JButtonType) {
    self.text = text
    self.type = type
  }

  var body: some View {
    VStack {
      Text(text)
    }
    .frame(width: 200, height: 200) // tem q vir antes do background color
    .foregroundColor(type.fontColor)
    .background(type.backgroundColor)
  }
}

struct JButton_Previews: PreviewProvider {
  static var previews: some View {
    JButton(text: "Mutton", type: .primary)

  }
}
