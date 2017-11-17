//
//  SaveUserLocationViewController.swift
//  FriendShare
//
//  Created by Emma Steimann on 11/17/17.
//  Copyright © 2017 Emma Steimann. All rights reserved.
//

import UIKit
import GoogleMaps
import RealmSwift

class SaveUserLocationViewController: UIViewController {
  @IBOutlet weak var mapView: GMSMapView!
  @IBOutlet weak var UserLocationNameView: UIView!
  private var longitude:String?
  private var latitude:String?
  private var name:String?
  private var personId:String?
  private var placeName:String?
  var hideSaveButton = false
  
  func setUserInfo(longitude:String, latitude:String, name:String, personId:String, placeName:String) {
    self.longitude = longitude
    self.latitude = latitude
    self.name = name
    self.personId = personId
    self.placeName = placeName
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mapView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self.view)
      make.height.equalTo(self.view.frame.height * 0.75)
      make.width.equalTo(self.view)
    }
    
    UserLocationNameView.snp.makeConstraints { (make) -> Void in
      make.bottom.equalTo(self.view)
      make.height.equalTo(self.view.frame.height * 0.25)
      make.width.equalTo(self.view)
    }
    
    if let longitude = longitude, let latitude = latitude, let name = name, let personId = personId {
      let rightButtonItem = UIBarButtonItem.init(
        title: "Save!",
        style: .done,
        target: self,
        action: #selector(SaveUserLocationViewController.saveUserInfo(sender:))
      )
      
      rightButtonItem.tintColor = UIColor.green
      
      self.navigationItem.rightBarButtonItem = rightButtonItem

      if hideSaveButton {
        self.navigationItem.rightBarButtonItem = nil
      }
      
      var label = UILabel()
      
      UserLocationNameView.addSubview(label)
      label.text = placeName
      let font = UIFont.boldSystemFont(ofSize: 26)
      label.font = font
      label.textColor = UIColor.white

      let height = label.text?.height(withConstrainedWidth: self.UserLocationNameView.frame.width, font: font)
      let width = label.text?.width(withConstraintedHeight: 40, font: font)

      label.frame = CGRect(x: 0, y: 0, width: width!, height: height!)

      label.snp.makeConstraints { (make) -> Void in
        make.center.equalTo(self.UserLocationNameView)
      }

      configureMap()
    }
  }
  
  @objc func saveUserInfo(sender: UIBarButtonItem) {
    let userInfo = UserDataLocationInfo()
    userInfo.name = name!
    userInfo.longitude = longitude!
    userInfo.latitude = latitude!
    userInfo.personId = personId!
    userInfo.placeName = placeName!
    var writeSuccessful = true
    let realm = try! Realm()
 
    do {
      try realm.write {
        realm.add(userInfo)
      }
    } catch {
      writeSuccessful = false
    }
    
    if writeSuccessful {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! ViewController
        self.navigationController?.setViewControllers([mainVC], animated: false)
        self.dismiss(animated: true, completion: nil)
        let alert = UIAlertController(title: "User Location added", message: "Your friends location was added", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "YAY!", style: UIAlertActionStyle.default, handler: nil))
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
  }
  
  private func configureMap() {
    if let longitude = longitude, let latitude = latitude {
      let loc = CLLocationCoordinate2D(latitude: Double(latitude)!, longitude: Double(longitude)!)
      let marker = GMSMarker(position: loc)
      marker.map = mapView
      mapView.camera = GMSCameraPosition(target: loc, zoom: 15, bearing: 0,
                                         viewingAngle: 0)
      mapView.isUserInteractionEnabled = false
    }
  }
  


}
