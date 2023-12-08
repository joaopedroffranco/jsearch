//
//  Created by João Pedro Fabiano Franco
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var mainRouter: MainRouter?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow(frame: UIScreen.main.bounds)
    startApp()

    return true
  }

  private func startApp() {
    let navigationController = UINavigationController()

    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()

    mainRouter = MainRouter(navigationController: navigationController)
    mainRouter?.start()
  }
}



