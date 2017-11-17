//
//  LoginViewController.swift
//  FriendShare
//
//  Created by Emma Steimann on 11/17/17.
//  Copyright © 2017 Emma Steimann. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import FacebookCore

class LoginViewController: UIViewController, LoginButtonDelegate {
  @IBOutlet weak var LoadingLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    LoadingLabel.isHidden = true
    let loginButton = LoginButton(readPermissions: [ .publicProfile ])
    loginButton.center = view.center
    loginButton.delegate = self

    view.addSubview(loginButton)
    
    if let accessToken = FBSDKAccessToken.current(){
      LoadingLabel.isHidden = false
      loginButton.isHidden = true
      getFBUserData()
    }
  }
  
  func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
    self.getFBUserData()
  }
  
  func loginButtonDidLogOut(_ loginButton: LoginButton) {
    print("logged out")
  }
  
  @objc func loginButtonClicked() {
    let loginManager = LoginManager()
    let readPermissions: [ReadPermission] = [.publicProfile]
    loginManager.logIn(readPermissions: readPermissions, viewController: self, completion: { loginResult in
      switch loginResult {
      case .failed(let error):
        print(error)
      case .cancelled:
        print("User cancelled login.")
      case .success(let grantedPermissions, let declinedPermissions, let accessToken):
        self.getFBUserData()
      }
    })
  }
  
  func getFBUserData(){
    if((FBSDKAccessToken.current()) != nil){
      FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
        if (error == nil){
          UserData.sharedInstance.userAccount = result as! [String : AnyObject]
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! ViewController
          self.navigationController?.setViewControllers([mainVC], animated: false)
          self.dismiss(animated: true, completion: nil)
        }
      })
    }
  }

}
