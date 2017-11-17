//
//  GMSPlace+Extensions.swift
//  FriendShare
//
//  Created by Emma Steimann on 11/17/17.
//  Copyright © 2017 Emma Steimann. All rights reserved.
//

import Foundation
import GooglePlaces

extension GMSPlace {
  func toJSONString() -> String {
    let dict = ["latitude": String(self.coordinate.latitude),
            "longitude": String(self.coordinate.longitude),
            "name": self.name,
            "placeID": self.placeID]
    var jsonData:Data?
    do {
    jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
    } catch {}
    let jsonString = String(data: jsonData!, encoding: .utf8)
    return jsonString!
  }
}
