//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI
import JUI

public struct ShiftsScreen: View {
  @ObservedObject var screenViewModel: ShiftsScreenViewModel

  public var body: some View {
    mainView
      .onLoad { screenViewModel.getTodayShifts() }
      .refreshable { screenViewModel.getTodayShifts(isPullRefreshing: true) }
  }

  @ViewBuilder
  private var mainView: some View {
    switch screenViewModel.state {
    case .initial: initialView
    case .loading: loadingView
    case .error: errorView
    case let .loaded(viewModels): loadedView(viewModels: viewModels)
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
    viewModel.state = .loaded(viewModels: [shiftsViewModel])
    return viewModel
  }()

  static var previews: some View {
    Group {
      ShiftsScreen(screenViewModel: initialState)
        .previewDisplayName("Initial")
      ShiftsScreen(screenViewModel: loadingState)
        .previewDisplayName("Loading")
      ShiftsScreen(screenViewModel: errorState)
        .previewDisplayName("Error")
      ShiftsScreen(screenViewModel: loadedState)
        .previewDisplayName("Loaded")
    }
  }
}
