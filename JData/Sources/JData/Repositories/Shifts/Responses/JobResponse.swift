//
//  Created by João Pedro Fabiano Franco
//

import Foundation

public protocol JobModel {
  var clientName: String { get }
  var imageURL: URL { get }
  var category: String { get }
  var address: AddressModel { get }
}

struct JobResponse: Decodable, JobModel {
  let clientName: String
  let imageURL: URL
  let category: String
  let address: AddressModel

  enum CodingKeys: String, CodingKey {
    case title
    case project
    case category
    case address = "report_at_address"
  }

  enum ProjectKeys: String, CodingKey {
    case client
  }

  enum ClientKeys: String, CodingKey {
    case name
    case links
  }

  enum LinksKeys: String, CodingKey {
    case heroImage = "hero_image"
  }

  enum CategoryKeys: String, CodingKey {
    case nameTranslation = "name_translation"
  }

  enum NameTranslationKeys: String, CodingKey {
    case english = "en_GB"
    case englishDutch = "en_NL"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    let projectValues = try values.nestedContainer(keyedBy: ProjectKeys.self, forKey: .project)

    let clientValues = try projectValues.nestedContainer(keyedBy: ClientKeys.self, forKey: .client)
    let linksValues = try clientValues.nestedContainer(keyedBy: LinksKeys.self, forKey: .links)

    let categoryValues = try values.nestedContainer(keyedBy: CategoryKeys.self, forKey: .category)
    let nameTranslationValues = try categoryValues.nestedContainer(keyedBy: NameTranslationKeys.self, forKey: .nameTranslation)

    address = try values.decode(AddressResponse.self, forKey: .address)
    clientName = try clientValues.decode(String.self, forKey: .name)
    imageURL = try linksValues.decode(URL.self, forKey: .heroImage)

    let englishCategory = try? nameTranslationValues.decode(String.self, forKey: .english)
    let englishDutchCategory = try? nameTranslationValues.decode(String.self, forKey: .englishDutch)
    category = englishCategory ?? englishDutchCategory ?? "Job"
  }
}
