//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import CoreLocation

public protocol LocationDelegate: AnyObject {
  func didChangeAuthorizationStatus()
}

public protocol LocationProtocol {
  var delegate: LocationDelegate? { get set }
  var currentLocation: CLLocation? { get }
  var currentStatus: LocationAuthorizationStatus { get }
}

public class LocationManager: NSObject, LocationProtocol {

  public weak var delegate: LocationDelegate?
  var nativeLocationManager: CLLocationManager

  public var currentLocation: CLLocation? {
    guard currentStatus == .authorized else { return nil }
    return nativeLocationManager.location
  }

  public var currentStatus: LocationAuthorizationStatus

  public init(nativeLocationManager: CLLocationManager = CLLocationManager()) {
    self.nativeLocationManager = nativeLocationManager
    self.currentStatus = LocationAuthorizationStatus(from: self.nativeLocationManager.authorizationStatus)
    super.init()
    self.nativeLocationManager.delegate = self
    requestAuthorizationIfNeeded()
  }

  private func requestAuthorizationIfNeeded() {
    nativeLocationManager.requestWhenInUseAuthorization()
  }
}

extension LocationManager: CLLocationManagerDelegate {
  public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    let newStatus = LocationAuthorizationStatus(from: manager.authorizationStatus)

    if newStatus != currentStatus {
      currentStatus = newStatus
      delegate?.didChangeAuthorizationStatus()
    }
  }
}
