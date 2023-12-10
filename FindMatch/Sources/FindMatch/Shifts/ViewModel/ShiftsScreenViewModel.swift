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
  private var locationManager: LocationProtocol
  private let getFollowingThreshold = 2
  private var cancellables = Set<AnyCancellable>()

  public init(
    shiftsRepository: ShiftsRepositoryProtocol = ShiftsRepository(),
    locationManager: LocationProtocol = LocationManager()
  ) {
    self.shiftsRepository = shiftsRepository
    self.locationManager = locationManager
    self.locationManager.delegate = self
  }


  // MARK: - Get Shifts

  func getTodayShifts(isPullRefreshing: Bool = false) {
    if isPullRefreshing {
      reset()
    } else {
      state = .loading
    }

    guard locationManager.currentStatus != .requesting else { return }

    getShifts(from: currentDate)
      .receive(on: RunLoop.main)
      .map { todayShiftsViewModel -> ShiftsState in
        if let todayShiftsViewModel {
          return .loaded(viewModels: [todayShiftsViewModel])
        } else {
          return .error
        }
      }
      .assign(to: &$state)
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
      getShifts(from: followingDate)
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { _ in
          self.isLoadingFollowing = false
        }, receiveValue: { followingShiftsViewModel in
          if let followingShiftsViewModel {
            let newViewModels = viewModels + [followingShiftsViewModel]
            self.state = .loaded(viewModels: newViewModels)
            self.currentDate = followingDate
          }
        })
        .store(in: &cancellables)
    }
  }

  // MARK: - Router

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

// MARK: - Location Delegate

extension ShiftsScreenViewModel: LocationDelegate {
  public func didChangeAuthorizationStatus() {
    getTodayShifts()
  }
}

// MARK: - Private

private extension ShiftsScreenViewModel {
  func getShifts(from date: Date) -> AnyPublisher<ShiftsViewModel?, Never> {
    shiftsRepository
      .getShifts(for: date)
      .map { self.viewModel(from: $0, date: date) }
      .eraseToAnyPublisher()
  }

  func viewModel(from model: ShiftsModel?, date: Date) -> ShiftsViewModel? {
    ShiftsViewModel(shiftsModel: model, from: date, currentLocation: locationManager.currentLocation)
  }

  func shouldGetMoreShifts(sectionIndex: Int, daysCount: Int, index: Int, shiftsCount: Int) -> Bool {
    sectionIndex == daysCount - 1 && index > shiftsCount - getFollowingThreshold
  }

  func reset() {
    isLoadingFollowing = false
    currentDate = .today
  }
}
