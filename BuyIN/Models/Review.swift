//
//  Review.swift
//  BuyIN
//
//  Created by Amr Hossam on 23/03/2022.
//

import Foundation


struct ReviewResponse: Codable {
    let reviews: [Review]
}

struct Review: Codable {
    let itemID: String
    let reviewAuthor: String
    let reviewText: String
}


extension Review {
    var dictionary: [String: Any]? {
      guard let data = try? JSONEncoder().encode(self) else { return nil }
      return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
