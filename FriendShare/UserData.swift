//
//  UserData.swift
//  FriendShare
//
//  Created by Emma Steimann on 11/17/17.
//  Copyright © 2017 Emma Steimann. All rights reserved.
//

import Foundation
import GooglePlaces
import DeepLinkKit
import CryptoSwift

class UserData {
  static let sharedInstance = UserData()
  var userAccount : [String : AnyObject]!
  
  func getUserDeepLinkForPlace(place:GMSPlace) -> DPLMutableDeepLink {
    var deepLink = DPLMutableDeepLink(string: "FriendShare://hello")!
    print(place.toJSONString())
    let acct = ["id": userAccount["id"], "name": userAccount["name"]]
    var jsonData:Data?
    do {
      jsonData = try JSONSerialization.data(withJSONObject: acct, options: .prettyPrinted)
    } catch {}
    let jsonString = String(data: jsonData!, encoding: .utf8)
    
    let encryptedPlace = encryptToHexString(place.toJSONString())
    let encryptedAccount = encryptToHexString(jsonString!)

    deepLink["place"] = encryptedPlace
    deepLink["user"] = encryptedAccount
    return deepLink
  }
  
  func encryptToHexString(_ toEncrypt:String) -> String? {
    var string:String?
    do {
      let aes = try AES(key: RabbitKey, iv: RabbitIV)
      let placeEncrypted = try aes.encrypt(Array(toEncrypt.utf8))
      return placeEncrypted.toHexString()
    } catch {
      print(error)
    }
    return string
  }
  
  func decryptHexString(_ toDecrypt:String) -> String? {
    var string:String?
    do {
      let aes = try AES(key: RabbitKey, iv: RabbitIV)
      let array:Array<UInt8> = Array(hex: toDecrypt)
      let decrypted = try aes.decrypt(array)
      return decrypted.toHexString()
    } catch {
      print(error)
    }
    return string
  }
  
}
