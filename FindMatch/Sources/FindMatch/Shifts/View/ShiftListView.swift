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
        spacing: DesignSystem.Spacings.small
      ) {
        ForEach(
          Array(viewModels.enumerated()),
          id: \.offset
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
    Section {
      Text(shiftsViewModel.day)
        .font(DesignSystem.Fonts.header)
        .foregroundColor(DesignSystem.Colors.header)
    }
    .padding(.vertical, DesignSystem.Spacings.xs)

    ForEach(
      Array(shiftsViewModel.shiftViewModels.enumerated()),
      id: \.offset
    ) { index, item in
      itemView(item)
        .onAppear { onItemAppear?(sectionIndex, index) }
    }
    .padding(.horizontal, DesignSystem.Spacings.xs)
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
