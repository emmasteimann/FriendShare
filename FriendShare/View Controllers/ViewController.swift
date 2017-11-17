//
//  ViewController.swift
//  FriendShare
//
//  Created by Emma Steimann on 11/16/17.
//  Copyright © 2017 Emma Steimann. All rights reserved.
//

import UIKit
import SnapKit
import GoogleMaps

class ViewController: UIViewController {

  @IBOutlet weak var ShareLocationButton: UIButton!
  @IBOutlet weak var ShareLocationView: UIView!
  @IBOutlet weak var FriendHistoryView: UIView!
  
  @IBOutlet weak var FriendHistoryButton: UIButton!
  @IBAction func clickShare(_ sender: Any) {
  }
  
  @IBAction func clickHistory(_ sender: Any) {
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(true)
    navigationController?.setNavigationBarHidden(false, animated: false)
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ShareLocationView.snp.makeConstraints { (make) -> Void in
      make.width.equalTo(self.view.frame.width)
      make.height.equalTo((self.view.frame.height / 2))
      make.top.equalTo(self.view)
    }
    
    FriendHistoryView.snp.makeConstraints { (make) -> Void in
      make.width.equalTo(self.view.frame.width)
      make.height.equalTo((self.view.frame.height / 2))
      make.bottom.equalTo(self.view)
    }
    
    ShareLocationButton.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(ShareLocationView)
    }
    
    FriendHistoryButton.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(FriendHistoryView)
    }
    if UserData.sharedInstance.pendingSave {
      let userLocInfo = UserData.sharedInstance.pendingLocationSave!
      UserData.sharedInstance.pendingLocationSave = nil
      UserData.sharedInstance.pendingSave = false
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let saveVc = storyboard.instantiateViewController(withIdentifier: "SaveUserLocationViewController") as! SaveUserLocationViewController
      saveVc.setUserInfo(longitude: userLocInfo["longitude"] as! String, latitude: userLocInfo["latitude"] as! String, name: userLocInfo["name"]! as! String, personId: userLocInfo["personId"]! as! String, placeName: userLocInfo["placeName"]! as! String)
      self.navigationController?.pushViewController(saveVc, animated: true)
    }
  }

}

