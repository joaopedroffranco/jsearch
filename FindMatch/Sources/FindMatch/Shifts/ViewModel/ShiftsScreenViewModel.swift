//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import Combine
import JData
import JFoundation

protocol ShiftsScreenViewModelProtocol: AnyObject {
  var state: ShiftsState { get set }

  func getTodayShifts(isPullRefreshing: Bool)
  func getFollowingShiftsIfNeeded(section: Int, index: Int)

  func goLogin()
  func goSingUp()
  func goFilters()
  func goKaart()
}

public class ShiftsScreenViewModel: ObservableObject, ShiftsScreenViewModelProtocol {
  public weak var routerDelegate: FindMatchRouterDelegate?

  @Published var state: ShiftsState = .initial

  var isLoadingFollowing = false
  var currentDate: Date = .today

  private var shiftsRepository: ShiftsRepositoryProtocol
  private let getFollowingThreshold = 2

  public init(shiftsRepository: ShiftsRepositoryProtocol = ShiftsRepository()) {
    self.shiftsRepository = shiftsRepository
  }

  func getTodayShifts(isPullRefreshing: Bool = false) {
    if isPullRefreshing {
      reset()
    } else {
      state = .loading
    }

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
    if case let .loaded(viewModels) = state, let followingDate = currentDate.following(), !isLoadingFollowing {
      isLoadingFollowing = true
      Task {
        let followingShiftsViewModel = await getShifts(from: followingDate)
        Task { @MainActor in
          if let followingShiftsViewModel {
            let newViewModels = viewModels + [followingShiftsViewModel]
            state = .loaded(viewModels: newViewModels)
            currentDate = followingDate
          }
          isLoadingFollowing = false
        }
      }
    }
  }

  func goLogin() {
    routerDelegate?.goLogin()
  }

  func goSingUp() {
    routerDelegate?.goSignUp()
  }

  func goFilters() {
    routerDelegate?.goFilters()
  }

  func goKaart() {
    routerDelegate?.goKaart()
  }

  deinit {
    routerDelegate?.dismiss()
    routerDelegate = nil
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

  func reset() {
    isLoadingFollowing = false
    currentDate = .today
  }
}
