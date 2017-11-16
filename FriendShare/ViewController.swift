//
//  ViewController.swift
//  FriendShare
//
//  Created by Emma Steimann on 11/16/17.
//  Copyright © 2017 Emma Steimann. All rights reserved.
//

import UIKit
import ContactsUI
import SnapKit

class ViewController: UIViewController, CNContactPickerDelegate {

  @IBOutlet weak var ShareLocationView: UIView!
  @IBOutlet weak var FriendHistoryView: UIView!
  
  @IBAction func clickShare(_ sender: Any) {
//    let cnPicker = CNContactPickerViewController()
//    cnPicker.delegate = self
//    self.present(cnPicker, animated: true, completion: nil)
  }
  
  @IBAction func clickHistory(_ sender: Any) {
//    let cnPicker = CNContactPickerViewController()
//    cnPicker.delegate = self
//    self.present(cnPicker, animated: true, completion: nil)
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
    
  }
  
  func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
    contacts.forEach { contact in
      for number in contact.phoneNumbers {
        let phoneNumber = number.value
        print("number is = \(phoneNumber)")
      }
    }
  }
  
  func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
    print("Cancel Contact Picker")
  }

}

