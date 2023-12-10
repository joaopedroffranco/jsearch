//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI
import JUI
import JData
import JFoundation

typealias ItemOnAppear = (Int, Int) -> Void

struct ShiftListView: View {
  var viewModels: [ShiftsViewModel]
  var onItemAppear: ItemOnAppear?

  var body: some View {
    ScrollView {
      LazyVStack(
        alignment: .leading,
        spacing: DesignSystem.Spacings.small,
        pinnedViews: [.sectionHeaders]
      ) {
        ForEach(
          Array(viewModels.enumerated()),
          id: \.element.hashValue
        ) {
          sectionView($0.element, sectionIndex: $0.offset)
        }
      }
      .padding(.trailing, DesignSystem.Spacings.standard)
    }
    .padding(.leading, DesignSystem.Spacings.standard)
  }

  @ViewBuilder
  private func sectionView(_ shiftsViewModel: ShiftsViewModel, sectionIndex: Int) -> some View {
    Section(
      content: {
        ForEach(
          Array(shiftsViewModel.shiftViewModels.enumerated()),
          id: \.element.hashValue
        ) { index, item in
          itemView(item)
            .onAppear { onItemAppear?(sectionIndex, index) }
        }
        .padding(.horizontal, DesignSystem.Spacings.xs)
      },
      header: {
        Text(shiftsViewModel.day)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.vertical, DesignSystem.Spacings.xs)
          .font(DesignSystem.Fonts.header)
          .foregroundColor(DesignSystem.Colors.header)
          .background(DesignSystem.Colors.background)
      }
    )
  }

  @ViewBuilder
  private func itemView(_ shift: ShiftViewModel) -> some View {
    JTile(
      imageType: shift.image,
      title: shift.title,
      info: shift.info.uppercased(),
      description: shift.period,
      tag: shift.earningsPerHour
    )
  }
}

struct ShiftListView_Previews: PreviewProvider {
  static var previews: some View {
    ShiftListView(
      viewModels: [ShiftsScreenPreviewModel.shiftsViewModel()],
      onItemAppear: nil
    )
  }
}
