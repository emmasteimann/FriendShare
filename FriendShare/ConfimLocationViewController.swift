//
//  ConfimLocationViewController.swift
//  FriendShare
//
//  Created by Emma Steimann on 11/17/17.
//  Copyright © 2017 Emma Steimann. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SnapKit
import ContactsUI
import MessageUI

class ConfimLocationViewController: UIViewController, CNContactPickerDelegate, MFMessageComposeViewControllerDelegate {
  @IBOutlet weak var mapView: GMSMapView!
  @IBOutlet weak var LocationTitleView: UIView!
  private var place: GMSPlace?

  func setPlace(place: GMSPlace) {
    self.place = place
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mapView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self.view)
      make.height.equalTo(self.view.frame.height * 0.75)
      make.width.equalTo(self.view)
    }
    
    LocationTitleView.snp.makeConstraints { (make) -> Void in
      make.bottom.equalTo(self.view)
      make.height.equalTo(self.view.frame.height * 0.25)
      make.width.equalTo(self.view)
    }
    if let place = place {
      let rightButtonItem = UIBarButtonItem.init(
        title: "Share!",
        style: .done,
        target: self,
        action: #selector(ConfimLocationViewController.confirmLocation(sender:))
      )
      
      rightButtonItem.tintColor = UIColor.green
      
      self.navigationItem.rightBarButtonItem = rightButtonItem
      
    
      let nameString = place.name
      let coords = String(place.coordinate.latitude) + ", " + String(place.coordinate.longitude)
      
      var label = UILabel()
      
      LocationTitleView.addSubview(label)
      
      if nameString != nil {
        label.text = nameString
      } else {
        label.text = coords
      }
      let font = UIFont.boldSystemFont(ofSize: 28)
      label.font = font
      label.textColor = UIColor.white
      
      let height = label.text?.height(withConstrainedWidth: self.LocationTitleView.frame.width, font: font)
      let width = label.text?.width(withConstraintedHeight: 40, font: font)
      
      label.frame = CGRect(x: 0, y: 0, width: width!, height: height!)
      
      label.snp.makeConstraints { (make) -> Void in
        make.center.equalTo(self.LocationTitleView)
      }
    
      configureMap()
    }
  }
  
  @objc func confirmLocation(sender: UIBarButtonItem) {
    let cnPicker = CNContactPickerViewController()
    cnPicker.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")
    
    // Ignore..
    //    cnPicker.predicateForEnablingContact = NSPredicate(format: "key == phoneNumber")
    //    cnPicker.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count == 1")
    cnPicker.delegate = self
    self.present(cnPicker, animated: true, completion: nil)
  }
  
  private func configureMap() {
    // Place a marker on the map and center it on the desired coordinates.
    // 39.627335, -105.152159
    let location =  CLLocationCoordinate2D(latitude: 39.627335, longitude: -105.152159)
    if let place = place {
      let marker = GMSMarker(position: place.coordinate)
      marker.map = mapView
      mapView.camera = GMSCameraPosition(target: place.coordinate, zoom: 15, bearing: 0,
                                         viewingAngle: 0)
      mapView.isUserInteractionEnabled = false
    }
  }
  
  func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
    if MFMessageComposeViewController.canSendText(){
      let contactPhoneValue = contact.phoneNumbers.first as! CNLabeledValue<CNPhoneNumber>
      
      let phone = contactPhoneValue.value.stringValue
      let msg:MFMessageComposeViewController = MFMessageComposeViewController()
      msg.recipients = [phone]
      msg.body = UserData.sharedInstance.getUserDeepLinkForPlace(place: self.place!).url.absoluteString
      msg.messageComposeDelegate = self
      self.present(msg, animated:true, completion:nil)
      
    }
    else {
      let alert = UIAlertController(title: "SMS not set up!", message: "FriendShare uses SMS to share your location. Please enable.", preferredStyle: UIAlertControllerStyle.alert)
      alert.addAction(UIAlertAction(title: "I'll go do that...  ", style: UIAlertActionStyle.default, handler: nil))
      UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
  }
  
  func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
    switch result {
    case .cancelled:
      print("Message was cancelled")
      controller.dismiss(animated: true, completion: nil)
      
    case .failed:
      print("Message failed")
      controller.dismiss(animated: true, completion: nil)
      
    case .sent:
      print("Message was sent")
      controller.dismiss(animated: false, completion: nil)
      
    default:
      break
    }
  }
  
  func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
    print("Cancel Contact Picker")
  }
  
}

