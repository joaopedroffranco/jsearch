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
  func getFollowingShiftsIfNeeded(section: Int, index: Int)
}

class ShiftsScreenViewModel: ObservableObject, ShiftsViewModelProtocol {
  @Published var state: ShiftsState = .initial

  private var shiftsRepository: ShiftsRepositoryProtocol
  private let getFollowingThreshold = 2

  var currentDate: Date = .today

  init(shiftsRepository: ShiftsRepositoryProtocol = ShiftsRepository()) {
    self.shiftsRepository = shiftsRepository
  }

  func getTodayShifts() {
    state = .loading

    Task {
      let todayShiftsViewModel = await getShifts(from: currentDate)

      Task { @MainActor in
        if let todayShiftsViewModel {
          state = .loaded(viewModels: [todayShiftsViewModel])
        } else {
          state = .error
        }
      }
    }
  }

  func getFollowingShiftsIfNeeded(section: Int, index: Int) {
    if
      case let .loaded(sections) = state,
      let viewModels = sections[safe: section]?.shiftViewModels,
      shouldGetMoreShifts(
        sectionIndex: section,
        daysCount: sections.count,
        index: index,
        shiftsCount: viewModels.count
      )
    {
      getFollowingShifts()
    }
  }

  func getFollowingShifts() {
    if case let .loaded(viewModels) = state, let followingDate = currentDate.following() {
      Task {
        if let followingShiftsViewModel = await getShifts(from: followingDate) {
          Task { @MainActor in
            let newViewModels = viewModels + [followingShiftsViewModel]
            state = .loaded(viewModels: newViewModels)
            currentDate = followingDate
          }
        }
      }
    }
  }
}

private extension ShiftsScreenViewModel {
  func getShifts(from date: Date) async -> ShiftsViewModel? {
    let shiftsModel = await shiftsRepository.getShifts(for: date)
    return viewModel(from: shiftsModel, date: date)
  }

  func viewModel(from model: ShiftsModel?, date: Date) -> ShiftsViewModel? {
    ShiftsViewModel(shiftsModel: model, from: date)
  }

  func shouldGetMoreShifts(sectionIndex: Int, daysCount: Int, index: Int, shiftsCount: Int) -> Bool {
    sectionIndex == daysCount - 1 && index > shiftsCount - getFollowingThreshold
  }
}
