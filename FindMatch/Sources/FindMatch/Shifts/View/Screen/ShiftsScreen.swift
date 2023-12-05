//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI
import JUI

struct ShiftsScreen: View {
  @ObservedObject var viewModel: ShiftsScreenViewModel

  var body: some View {
    mainView
      .onAppear { viewModel.getTodayShifts() }
  }

  @ViewBuilder
  private var mainView: some View {
    switch viewModel.state {
    case .initial: initialView
    case .loading: loadingView
    case .error: errorView
    case let .loaded(viewModel): loadedView(viewModel: viewModel)
    }
  }
}

struct ShiftsScreen_Previews: PreviewProvider {
  static let initialState: ShiftsScreenViewModel = {
    let viewModel = ShiftsScreenViewModel()
    viewModel.state = .initial
    return viewModel
  }()

  static let loadingState: ShiftsScreenViewModel = {
    let viewModel = ShiftsScreenViewModel()
    viewModel.state = .loading
    return viewModel
  }()

  static let errorState: ShiftsScreenViewModel = {
    let viewModel = ShiftsScreenViewModel()
    viewModel.state = .error
    return viewModel
  }()

  static let loadedState: ShiftsScreenViewModel = {
    let viewModel = ShiftsScreenViewModel()
    let shiftsViewModel = ShiftsScreenPreviewModel.shiftsViewModel()
    viewModel.state = .loaded(viewModel: shiftsViewModel)
    return viewModel
  }()

  static var previews: some View {
    Group {
      ShiftsScreen(viewModel: initialState)
        .previewDisplayName("Initial")
      ShiftsScreen(viewModel: loadingState)
        .previewDisplayName("Loading")
      ShiftsScreen(viewModel: errorState)
        .previewDisplayName("Error")
      ShiftsScreen(viewModel: loadedState)
        .previewDisplayName("Loaded")
    }
  }
}
