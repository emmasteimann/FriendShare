//
//  ShareViewController.swift
//  FriendShare
//
//  Created by Emma Steimann on 11/16/17.
//  Copyright © 2017 Emma Steimann. All rights reserved.
//

import UIKit
import GooglePlacePicker

class ShareViewController: UIViewController {
  @IBOutlet weak var MapSelectView: UIView!
  @IBOutlet weak var AutocompleteSelectView: UIView!
  @IBOutlet weak var ChooseOnMapButton: UIButton!
  @IBOutlet weak var AutocompleteLocationButton: UIButton!
  
  override func viewDidLoad() {
        super.viewDidLoad()

        MapSelectView.snp.makeConstraints { (make) -> Void in
          make.width.equalTo(self.view.frame.width)
          make.height.equalTo((self.view.frame.height / 2))
          make.top.equalTo(self.view)
        }
        AutocompleteSelectView.snp.makeConstraints { (make) -> Void in
          make.width.equalTo(self.view.frame.width)
          make.height.equalTo((self.view.frame.height / 2))
          make.bottom.equalTo(self.view)
        }
    }
  
    @IBAction func chooseOnMap(_ sender: Any) {
      let config = GMSPlacePickerConfig(viewport: nil)
      let placePicker = GMSPlacePickerViewController(config: config)
      placePicker.delegate = self
      placePicker.modalPresentationStyle = .popover
      placePicker.popoverPresentationController?.sourceView = ChooseOnMapButton
      placePicker.popoverPresentationController?.sourceRect = ChooseOnMapButton.bounds
      
      // Display the place picker. This will call the delegate methods defined below when the user
      // has made a selection.
      self.present(placePicker, animated: true, completion: nil)
    }
  
    @IBAction func autocompletePicker(_ sender: Any) {
    }
}

extension ShareViewController : GMSPlacePickerViewControllerDelegate {
  func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
    // Create the next view controller we are going to display and present it.
//    let nextScreen = ShareViewController(place: place)
//    self.splitPaneViewController?.push(viewController: nextScreen, animated: false)
//    self.mapViewController?.coordinate = place.coordinate
    
    // Dismiss the place picker.
    viewController.dismiss(animated: true, completion: nil)
  }
  
  func placePicker(_ viewController: GMSPlacePickerViewController, didFailWithError error: Error) {
    // In your own app you should handle this better, but for the demo we are just going to log
    // a message.
    NSLog("An error occurred while picking a place: \(error)")
  }
  
  func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
    NSLog("The place picker was canceled by the user")
    
    // Dismiss the place picker.
    viewController.dismiss(animated: true, completion: nil)
  }
}

