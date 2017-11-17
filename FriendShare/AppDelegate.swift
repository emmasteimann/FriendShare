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
  var sourceApp:String?
  var annotation:Any?
  

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    if kMapsAPIKey.isEmpty || kPlacesAPIKey.isEmpty {
      let msg = "Dude, no api key yo..."
      fatalError(msg)
    }
    
    GMSPlacesClient.provideAPIKey(kPlacesAPIKey)
    GMSServices.provideAPIKey(kMapsAPIKey)

    self.router = DPLDeepLinkRouter()
    self.router?.register("FriendShare://hello", routeHandlerBlock: { link in
      if let link = link {
        let userLocInfo = UserData.sharedInstance.processUserDeepLink(link: link)
        UserData.sharedInstance.pendingLocationSave = userLocInfo
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let saveVc = storyboard.instantiateViewController(withIdentifier: "SaveUserLocationViewController") as! SaveUserLocationViewController
        saveVc.setUserInfo(longitude: userLocInfo["longitude"] as! String, latitude: userLocInfo["latitude"] as! String, name: userLocInfo["name"]! as! String, personId: userLocInfo["personId"]! as! String, placeName: userLocInfo["placeName"]! as! String)
        var rootViewController = self.window!.rootViewController as! UINavigationController
        rootViewController.pushViewController(saveVc, animated: true)
      }
    })
    
    if launchOptions != nil {
      if let url = launchOptions![.url] as? URL, let annotation = launchOptions![.annotation] {
        UserData.sharedInstance.pendingSave = true
        return self.application(application, open: url, sourceApplication: launchOptions![.sourceApplication] as? String, annotation: annotation)
      }
    }
    
    return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func applicationWillResignActive(_ application: UIApplication) {
    FBSDKAppEvents.activateApp()
  }
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    return (self.router?.handle(url, withCompletion: nil))!
  }
  
  func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    if url.absoluteString.hasPrefix("fb") {
      return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    return (self.router?.handle(url, withCompletion: nil))!
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

