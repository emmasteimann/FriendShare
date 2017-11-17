//
//  ViewController.swift
//  FriendShare
//
//  Created by Emma Steimann on 11/16/17.
//  Copyright © 2017 Emma Steimann. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

  @IBOutlet weak var ShareLocationButton: UIButton!
  @IBOutlet weak var ShareLocationView: UIView!
  @IBOutlet weak var FriendHistoryView: UIView!
  
  @IBOutlet weak var FriendHistoryButton: UIButton!
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
    
    ShareLocationButton.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(ShareLocationView)
    }
    
    FriendHistoryButton.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(FriendHistoryView)
    }
  }

}

