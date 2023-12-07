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
    state = .loading

    Task {
      let today = Date.today
      let shiftsModel = await shiftsRepository.getShifts(for: today)
      let todayShiftsViewModel = viewModel(from: shiftsModel, date: today)

      Task { @MainActor in
        if let todayShiftsViewModel {
          state = .loaded(viewModels: [todayShiftsViewModel])
        } else {
          state = .error
        }
      }
    }
  }
}

private extension ShiftsScreenViewModel {
  func viewModel(from model: ShiftsModel?, date: Date) -> ShiftsViewModel? {
    ShiftsViewModel(shiftsModel: model, from: date)
  }
}
