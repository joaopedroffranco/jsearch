//
//  Created by João Pedro Fabiano Franco
//

import Foundation
import JFoundation

protocol FindMatchRouterDelegate: RouterDelegate {
  func goFilters()
  func goKaart()
  func goLogin()
  func goSignUp()
}
