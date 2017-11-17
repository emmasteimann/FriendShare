//
//  TableViewCell.swift
//  FriendShare
//
//  Created by Emma Steimann on 11/17/17.
//  Copyright © 2017 Emma Steimann. All rights reserved.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
  var label: UILabel = UILabel()
  var firstLoad = true
  var cellString:String = ""
  override func awakeFromNib() {
        super.awakeFromNib()
    }
  
    override func layoutSubviews() {
      if firstLoad {
        self.contentView.addSubview(label)
        self.firstLoad = false
      }
      if cellString != "" {
        label.snp.makeConstraints { (make) -> Void in
          make.width.equalTo(self.contentView)
          make.height.equalTo(self.contentView)
        }
        label.text = cellString
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.black
      }
    }
  
    override func prepareForReuse() {
      label.text = ""
    }

}
