//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI
import JUI
import JData
import JFoundation

struct ShiftListView: View {
  var viewModels: [ShiftsViewModel]

  var body: some View {
    ScrollView {
      LazyVStack(
        alignment: .leading,
        spacing: DesignSystem.Spacings.small
      ) {
        ForEach(Array(viewModels.enumerated()), id: \.offset) {
          sectionView($0.element)
        }
      }
    }
    .padding(.horizontal, DesignSystem.Spacings.standard)
  }

  @ViewBuilder
  private func sectionView(_ shiftsViewModel: ShiftsViewModel) -> some View {
    Section {
      Text(shiftsViewModel.day)
        .font(DesignSystem.Fonts.header)
        .foregroundColor(DesignSystem.Colors.header)
    }
    .padding(.vertical, DesignSystem.Spacings.xs)

    ForEach(Array(shiftsViewModel.shiftViewModels.enumerated()), id: \.offset) {
      itemView($0.element)
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
    ShiftListView(viewModels: [ShiftsScreenPreviewModel.shiftsViewModel()])
  }
}
