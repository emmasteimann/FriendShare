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
    
    let height = (self.view.frame.height / 2)
    MapSelectView.snp.makeConstraints { (make) -> Void in
      make.width.equalTo(self.view.frame.width)
      make.height.equalTo(height)
      make.top.equalTo(self.view)
    }
    
    AutocompleteSelectView.snp.makeConstraints { (make) -> Void in
      make.width.equalTo(self.view.frame.width)
      make.height.equalTo(height)
      make.bottom.equalTo(self.view)
    }
    
    ChooseOnMapButton.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(MapSelectView)
    }
    
    AutocompleteLocationButton.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(AutocompleteSelectView)
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
    let autocompleteController = GMSAutocompleteViewController()
    autocompleteController.delegate = self
    present(autocompleteController, animated: true, completion: nil)
  }
}

extension ShareViewController : GMSPlacePickerViewControllerDelegate {
  func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let confirmLocationVC = storyboard.instantiateViewController(withIdentifier: "ConfimLocationViewController") as! ConfimLocationViewController
    confirmLocationVC.setPlace(place:place)
    self.navigationController?.pushViewController(confirmLocationVC, animated: false)
    viewController.dismiss(animated: true, completion: nil)
  }
  
  func placePicker(_ viewController: GMSPlacePickerViewController, didFailWithError error: Error) {
    NSLog("An error occurred while picking a place: \(error)")
  }
  
  func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
    NSLog("The place picker was canceled by the user")
    
    viewController.dismiss(animated: true, completion: nil)
  }
}

extension ShareViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let confirmLocationVC = storyboard.instantiateViewController(withIdentifier: "ConfimLocationViewController") as! ConfimLocationViewController
    confirmLocationVC.setPlace(place:place)
    self.navigationController?.pushViewController(confirmLocationVC, animated: false)
    viewController.dismiss(animated: true, completion: nil)
  }
  
  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    print("Error: ", error.localizedDescription)
  }
  
  // User canceled the operation.
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }
  
  // Turn the network activity indicator on and off again.
  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }
  
  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }
  
}
