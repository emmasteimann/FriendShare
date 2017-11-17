//
//  FriendShareTests.swift
//  FriendShareTests
//
//  Created by Emma Steimann on 11/16/17.
//  Copyright © 2017 Emma Steimann. All rights reserved.
//

import Quick
import Nimble
import XCTest
import DeepLinkKit
import SwiftyJSON
@testable import FriendShare

class UserDataSpec: QuickSpec {
  override func spec() {
    describe("User Data Encryption") {
      context("when encrypting a string") {
        var uD:UserData!
        var myString:String!
        beforeEach {
          uD = UserData.sharedInstance
          myString = "hello"
        }
        it("we get back the same string when decrypting") {
          let encryptedValue = uD.encryptToHexString(myString)
          expect(encryptedValue).toNot(equal(myString))
          let decryptedValue = uD.decryptHexString(encryptedValue!)
          expect(decryptedValue).to(equal(myString))
        }
      }
    }
    describe("Deep Link Processing") {
      context("when process a users deep link") {
        var uD:UserData!
        var dpl:DPLDeepLink!
        beforeEach {
          uD = UserData.sharedInstance
          dpl = self.preparDPL()
        }
        it("we get back a dictionary containing valid data") {
          expect(dpl).to(beAKindOf(DPLDeepLink.self))
          var processed = uD.processUserDeepLink(link: dpl)
          expect(processed).to(beAKindOf(Dictionary<String, Any>.self))
          var personId = processed["personId"]
          expect(personId).to(be(equal("1234")))
        }
      }
    }
  }
  
  func preparDPL() -> DPLDeepLink {
    var deepLink = DPLMutableDeepLink(string: "FriendShare://hello")!
    let acct = ["id": "1234", "name": "Emma"]
    var jsonData:Data?
    do {
      jsonData = try JSONSerialization.data(withJSONObject: acct, options: .prettyPrinted)
    } catch {}
    let jsonString = String(data: jsonData!, encoding: .utf8)
    
    let encryptedPlace = UserData.sharedInstance.encryptToHexString("{'placeName':'Meow','latitude':'39.627335','longitude':'-105.152159'}")
    let encryptedAccount = UserData.sharedInstance.encryptToHexString(jsonString!)
    
    deepLink["place"] = encryptedPlace
    deepLink["user"] = encryptedAccount
    return deepLink
  }
}
