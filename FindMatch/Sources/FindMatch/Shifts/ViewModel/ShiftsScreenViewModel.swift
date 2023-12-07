//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import Combine
import JData
import JFoundation

protocol ShiftsViewModelProtocol: AnyObject {
  var state: ShiftsState { get set }

  func getTodayShifts()
}

class ShiftsScreenViewModel: ObservableObject, ShiftsViewModelProtocol {
  @Published var state: ShiftsState = .initial

  private var shiftsRepository: ShiftsRepositoryProtocol

  init(shiftsRepository: ShiftsRepositoryProtocol = ShiftsRepository()) {
    self.shiftsRepository = shiftsRepository
  }

  func getTodayShifts() {
    Task {
      let shiftsModel = await shiftsRepository.getShifts(for: Date.today)
      let shiftsViewModel = viewModel(from: shiftsModel)

      Task { @MainActor in
        if let shiftsViewModel {
          state = .loaded(viewModel: shiftsViewModel)
        } else {
          state = .error
        }
      }
    }
  }
}

private extension ShiftsScreenViewModel {
  func viewModel(from model: ShiftsModel?) -> ShiftsViewModel? {
    ShiftsViewModel(shiftsModel: model)
  }
}
