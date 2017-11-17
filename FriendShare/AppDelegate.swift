//
//  AppDelegate.swift
//  FriendShare
//
//  Created by Emma Steimann on 11/16/17.
//  Copyright © 2017 Emma Steimann. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import DeepLinkKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var router:DPLDeepLinkRouter?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    if kMapsAPIKey.isEmpty || kPlacesAPIKey.isEmpty {
      let msg = "Dude, no api key yo..."
      fatalError(msg)
    }
    
    GMSPlacesClient.provideAPIKey(kPlacesAPIKey)
    GMSServices.provideAPIKey(kMapsAPIKey)

    self.router = DPLDeepLinkRouter()
    
    self.router.register("fb") { link in
      if let link = link {
        print("\(link.routeParameters["message"])")
      }
    }
    
    return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func applicationWillResignActive(_ application: UIApplication) {
    FBSDKAppEvents.activateApp()
  }
  
  func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
  }

  func applicationWillTerminate(_ application: UIApplication) {
  }


}

