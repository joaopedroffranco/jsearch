//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI
import JUI
import JData

struct ShiftListView: View {
  var viewModel: ShiftsViewModel

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

    ForEach(Array(viewModel.shifts.enumerated()), id: \.offset) {
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
    ShiftListView(viewModel: ShiftsScreenPreviewModel.shiftsViewModel())
  }
}
