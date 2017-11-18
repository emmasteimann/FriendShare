//
//  HistoryTableViewController.swift
//  FriendShare
//
//  Created by Emma Steimann on 11/17/17.
//  Copyright © 2017 Emma Steimann. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryTableViewController: UITableViewController {
    var userLocations:[UserDataLocationInfo] = [UserDataLocationInfo]()
    override func viewDidLoad() {
      super.viewDidLoad()
      loadUserData()
      self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
      self.tableView.backgroundColor = UIColor(red:1.00, green:0.99, blue:0.67, alpha:1.0)
    }
  
    func loadUserData() {
      let realm = try! Realm()
      let uls = realm.objects(UserDataLocationInfo.self)
      userLocations = Array(uls)
      self.tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userLocations.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
      
        if let ul = userLocations[indexPath.row] as? UserDataLocationInfo {
          let txt = ul.name + " - " + ul.placeName
          cell.cellString = txt
        }
      
        return cell
    }
 
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let userLocInfo = userLocations[indexPath.row] as? UserDataLocationInfo {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let saveVc = storyboard.instantiateViewController(withIdentifier: "SaveUserLocationViewController") as! SaveUserLocationViewController
      saveVc.setUserInfo(longitude: userLocInfo["longitude"] as! String, latitude: userLocInfo["latitude"] as! String, name: userLocInfo["name"]! as! String, personId: userLocInfo["personId"]! as! String, placeName: userLocInfo["placeName"]! as! String)
      saveVc.hideSaveButton = true
      self.navigationController?.pushViewController(saveVc, animated: true)
    }
  }
  
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if (indexPath.row % 2 == 0)
    {
      cell.backgroundColor = UIColor(red:0.00, green:0.76, blue:1.00, alpha:1.0)
    } else {
      cell.backgroundColor = UIColor(red:0.99, green:0.64, blue:0.85, alpha:1.0)
      
    }
  }

}
