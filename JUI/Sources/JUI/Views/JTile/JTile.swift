//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI
import Kingfisher

public struct JTile: View {
  let imageType: ImageType
  let title: String
  let info: String
  let description: String
  let tag: String
  let height: CGFloat

  public init(
    imageType: ImageType,
    title: String,
    info: String,
    description: String,
    tag: String,
    height: CGFloat = 200
  ) {
    self.imageType = imageType
    self.title = title
    self.info = info
    self.description = description
    self.tag = tag
    self.height = height
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: DesignSystem.Spacings.standard) {
      ZStack(alignment: .bottomTrailing) {
        imageView
          .frame(height: height)
          .frame(maxWidth: .infinity)

        Text(tag)
          .padding(.leading, DesignSystem.Spacings.xs)
          .padding([.trailing, .top, .bottom], DesignSystem.Spacings.xxxs)
          .background(DesignSystem.Colors.background)
          .font(DesignSystem.Fonts.price)
          .foregroundColor(DesignSystem.Colors.secondary)
      }
      .background(Color.blue)
      .cornerRadius(DesignSystem.Radius.medium)

      VStack(alignment: .leading, spacing: DesignSystem.Spacings.xxs) {
        Text(info)
          .font(DesignSystem.Fonts.info)
          .foregroundColor(DesignSystem.Colors.info)
          .lineLimit(1)

        Text(title)
          .font(DesignSystem.Fonts.title)
          .foregroundColor(DesignSystem.Colors.title)
          .lineLimit(1)

        Text(description)
          .font(DesignSystem.Fonts.description)
          .foregroundColor(DesignSystem.Colors.description)
          .lineLimit(1)
      }
    }
  }

  @ViewBuilder
  private var imageView: some View {
    switch imageType {
    case let .local(name, bundle):
      Image(name, bundle: bundle)
        .resizable()
        .scaledToFill()
    case let .remote(url):
      KFImage(url)
        .resizable()
        .scaledToFill()
    }
  }
}

struct JTile_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 50) {
      JTile(
        imageType: .local(name: "tile_placeholder", bundle: .module),
        title: "This is the title with local image",
        info: "This is the info",
        description: "This is the description",
        tag: "$ tag"
      )

      JTile(
        imageType: .local(name: "tile_placeholder", bundle: .module),
        title: "This is the title with custom height",
        info: "This is the info",
        description: "This is the description",
        tag: "$ tag",
        height: 50
      )

      if let url = URL(string: "https://tmpr-photos2.fra1.digitaloceanspaces.com/hero/237936.jpg") {
        JTile(
          imageType: .remote(url: url),
          title: "This is a longer title with remote image, lorem ipsum, lorem ipsum, lorem ipsum",
          info: "This is the info",
          description: "This is the description",
          tag: "$ tag"
        )
      }
    }
    .padding()
    .frame(maxWidth: .infinity)
  }
}
