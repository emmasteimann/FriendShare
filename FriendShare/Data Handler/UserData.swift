//
//  UserData.swift
//  FriendShare
//
//  Created by Emma Steimann on 11/17/17.
//  Copyright © 2017 Emma Steimann. All rights reserved.
//

import UIKit
import GooglePlaces
import DeepLinkKit
import CryptoSwift
import RealmSwift

class UserDataLocationInfo : Object {
  @objc dynamic var name = ""
  @objc dynamic var longitude = ""
  @objc dynamic var latitude = ""
  @objc dynamic var personId = ""
  @objc dynamic var placeName = ""
}

class UserData {
  static let sharedInstance = UserData()
  var userAccount : [String : AnyObject]!
  var pendingSave:Bool = false
  var pendingLocationSave: [String: Any]? 
  
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
      return String(bytes: decrypted, encoding: String.Encoding.utf8)
    } catch {
      print(error)
    }
    return string
  }
  
  func processUserDeepLink(link: DPLDeepLink) -> [String:Any] {
    let placeHex = link.queryParameters["place"]
    let userHex = link.queryParameters["user"]
    
    let jsonStringPlace = decryptHexString(placeHex as! String)
    let jsonStringUser = decryptHexString(userHex as! String)
    
    let placeDictionary = convertToDictionary(text: jsonStringPlace!)
    let userDictionary = convertToDictionary(text: jsonStringUser!)

    let lat = placeDictionary!["latitude"] as! String
    let lon = placeDictionary!["longitude"] as! String
    
    return [
      "latitude": lat,
      "longitude": lon,
      "placeName": placeDictionary!["name"] as! String,
      "name": userDictionary!["name"],
      "personId": userDictionary!["id"]
    ]
  }
  
  func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
      do {
        return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
      } catch {
        print(error.localizedDescription)
      }
    }
    return nil
  }
}
