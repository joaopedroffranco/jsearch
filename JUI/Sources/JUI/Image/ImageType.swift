//
//  Created by João Pedro Fabiano Franco
//

import Foundation

public enum ImageType {
  case local(name: String, bundle: Bundle)
  case remote(url: URL)
}