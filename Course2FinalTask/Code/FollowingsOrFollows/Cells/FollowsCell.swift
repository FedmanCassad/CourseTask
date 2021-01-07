//
//  TableViewCell.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 17.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit

class FollowsCell: UITableViewCell {
  var user: User!
  var delegate: FeedCellDelegate?
  
  var singleTapRecognizer: UITapGestureRecognizer {
    let tchRecg = UITapGestureRecognizer(target: self, action: #selector(selectProfile))
    tchRecg.numberOfTapsRequired = 1
    tchRecg.numberOfTouchesRequired = 1
    return tchRecg
  }
  
  private lazy var avatarImage: UIImageView = {
    let img = UIImageView()
    img.clipsToBounds = true
    img.contentMode = .scaleAspectFit
    img.isUserInteractionEnabled = true
    img.translatesAutoresizingMaskIntoConstraints = false
    img.addGestureRecognizer(singleTapRecognizer)
    return img
  }()
  
  private lazy var userName: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.addGestureRecognizer(singleTapRecognizer)
    lbl.isUserInteractionEnabled = true
    return lbl
  }()
  
  func configure(user: User) {
    translatesAutoresizingMaskIntoConstraints = false
    
    self.user = user
    //Оставим это на техдолг
    avatarImage.kf.setImage(with: URL(string: user.avatar)!)
    avatarImage.frame = CGRect(x: 15, y: 0, width: 45, height: 45)
    
    userName.text = user.username
    userName.sizeToFit()
    userName.frame.origin.x = avatarImage.frame.maxX + 16
    userName.center.y = avatarImage.center.y
    
    addSubview(avatarImage)
    addSubview(userName)
    
    separatorInset.left = userName.frame.origin.x
    contentView.frame.size.height = avatarImage.frame.maxY
  }
  
  @objc func selectProfile() {
     Router.window?.lockTheView()
    delegate?.goToSelectedProfile(user: user)
  }
  
}
