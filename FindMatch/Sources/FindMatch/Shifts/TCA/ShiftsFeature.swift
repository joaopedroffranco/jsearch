//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import Combine
import JData
import JFoundation
import ComposableArchitecture

public struct ShiftsFeature: Reducer {
  public struct State: Equatable {
    enum View: Equatable {
      case initial
      case loading
      case loaded(viewModels: [ShiftsViewModel])
      case error
    }

    var viewState: View = .initial
    var isLoadingFollowing = false
    var currentDate: Date = .today
  }

  public enum Action {
    case getTodayShifts(isPullToRefresh: Bool)
    case itemDidAppear(section: Int, index: Int)
    case getFollowingShifts

    case fetched(shiftsViewModel: ShiftsViewModel, date: Date, shouldReset: Bool)
    case fetchFailed
  }

  private var shiftsRepository: ShiftsRepositoryProtocol
  private let getFollowingThreshold = 2
  private var cancellables = Set<AnyCancellable>()

  public init(shiftsRepository: ShiftsRepositoryProtocol = ShiftsRepository()) {
    self.shiftsRepository = shiftsRepository
  }

  public var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case let .getTodayShifts(isPullToRefresh):
        if isPullToRefresh {
          state.currentDate = .today
          state.isLoadingFollowing = false
        } else {
          state.viewState = .loading
        }

        let date = Date.today
        return .run { send in
          guard let shiftsViewModel = await getShifts(from: date) else {
            await send(.fetchFailed)
            return
          }

          await send(
            .fetched(
              shiftsViewModel: shiftsViewModel,
              date: date,
              shouldReset: isPullToRefresh
            )
          )
        }
      case let .itemDidAppear(section, index):
        if
          case let .loaded(sections) = state.viewState,
          let viewModels = sections[safe: section]?.shiftViewModels,
          shouldGetMoreShifts(
            sectionIndex: section,
            daysCount: sections.count,
            index: index,
            shiftsCount: viewModels.count
          )
        {
          return .run { send in await send(.getFollowingShifts) }
        }

        return .none
      case .getFollowingShifts:
        if
          case .loaded = state.viewState,
          let followingDate = state.currentDate.following(),
          !state.isLoadingFollowing
        {
          state.isLoadingFollowing = true

          return .run { send in
            guard let shiftsViewModel = await getShifts(from: followingDate) else { return }

            await send(
              .fetched(
                shiftsViewModel: shiftsViewModel,
                date: followingDate,
                shouldReset: false
              )
            )
          }
        }

        return .none
      case let .fetched(shiftsViewModel, date, shouldReset):
        switch (state.viewState, shouldReset) {
        case (.initial, _), (.error, _), (.loading, _), (.loaded, true):
          state.viewState = .loaded(viewModels: [shiftsViewModel])
        case let (.loaded(viewModels), false):
          let newViewModels = viewModels + [shiftsViewModel]
          state.viewState = .loaded(viewModels: newViewModels)
          state.currentDate = date
          state.isLoadingFollowing = false
        }

        return .none
      case .fetchFailed:
        state.viewState = .error
        return .none
      }
    }
  }
}

private extension ShiftsFeature {
  func getShifts(from date: Date) async -> ShiftsViewModel? {
    guard let models = await shiftsRepository.getShifts(for: date) else { return nil }
    return viewModel(from: models, date: date)
  }

  func viewModel(from model: ShiftsModel?, date: Date) -> ShiftsViewModel? {
    ShiftsViewModel(shiftsModel: model, from: date, currentLocation: nil)
  }

  func shouldGetMoreShifts(sectionIndex: Int, daysCount: Int, index: Int, shiftsCount: Int) -> Bool {
    sectionIndex == daysCount - 1 && index > shiftsCount - getFollowingThreshold
  }
}
