//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI
import JUI

struct JobListView: View {
  var body: some View {
    ScrollView {
      LazyVStack(
        alignment: .leading,
        spacing: DesignSystem.Spacings.small
      ) {
        sectionView()
      }
    }
    .padding(.horizontal, DesignSystem.Spacings.standard)
  }

  @ViewBuilder
  private func sectionView() -> some View {
    Section {
      Text("Sunday 8 December")
        .font(DesignSystem.Fonts.header)
        .foregroundColor(DesignSystem.Colors.header)
    }

    ForEach(1..<10) { _ in
      if let url = URL(string: "https://tmpr-photos2.fra1.digitaloceanspaces.com/hero/237936.jpg") {
        JTile(
          imageType: .remote(url: url),
          title: "Duincafé de Kenne",
          info: "SERVING • 12 km",
          description: "11:30 - 17:00",
          tag: "$ 13.55")
      }
    }
    .padding(.horizontal, DesignSystem.Spacings.xs)
  }
}

struct JobListView_Previews: PreviewProvider {
  static var previews: some View {
    JobListView()
  }
}
