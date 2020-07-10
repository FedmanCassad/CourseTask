//
//  TableViewCell.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 05.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider
class FeedCell: UITableViewCell {
  let statusbarHeight = UIApplication.shared.statusBarFrame.maxY
  
  
  //MARK: - Top footer (avatar,nickname,created time)
  private lazy var avatarImage: UIImageView = {
    let img = UIImageView()
    img.contentMode = .scaleAspectFit
    return img
  }()
  
  private lazy var usersName: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    
    return lbl
  }()
  
  private lazy var timeStamp: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    
    return lbl
  }()
  
  //MARK: - Post picture
  
  private lazy var postImage: UIImageView = {
    let imgView = UIImageView()
    imgView.contentMode = .scaleAspectFit
    return imgView
  }()
  
  //MARK: - Footer
  private lazy var likesLabel: UILabel = {
    let lbl = UILabel()
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
  }()
  
  private lazy var likeButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setImage(UIImage(named: "like"), for: .normal)
    button.tintColor = .lightGray
    button.sizeToFit()
    return button
  }()
  
  private lazy var commentLabel: UILabel = {
    let lbl = UILabel()
    lbl.numberOfLines = 0
    return lbl
  }()
  
  private lazy var bigLike: UIImageView = {
    let img = UIImage(named: "bigLike")
  
    let imgView = UIImageView(image: img)
    
    imgView.tintColor = .white
    return imgView
  }()
  
  
  func configure(with post: Post) {
    
    //MARK: - Initialising UIs with post data
    // Не понимаю почему, но без повторного 
    frame.size.width = UIScreen.main.bounds.width
    clipsToBounds = true
    avatarImage.image = post.authorAvatar
    usersName.text = post.authorUsername

    let formatter = DateFormatter()
    
    formatter.timeStyle = .medium
    formatter.dateStyle = .medium
    timeStamp.text = formatter.string(from: post.createdTime)
    postImage.image = post.image
    likesLabel.text = "Likes: \(post.likedByCount)"
    commentLabel.text = post.description
    commentLabel.sizeToFit()
    likesLabel.sizeToFit()
    usersName.sizeToFit()
    timeStamp.sizeToFit()
    
    //MARK: - Configuring layout by frames
    
    // Прошу обратить внимание, в рецензии к последней работе преподаватель попросил меня сверстать в следующем задании макет констрейтами, но к этой просьбе я испытываю внутреннее сопротивление, потому что как было сказанно в лекции, да с кодом заморачивать чуть дольше чем с констрейтами, но при запуске верстка фреймами исполняется раза в 4 быстрее. Поэтому мне бы хотелось сделать "прфессионально". С autolayout я знаю как работать и домашней работы по нему было достаточно, теперь хочется ручками поделать. Извините.
    avatarImage.frame = CGRect(x: 15, y: 8, width: 35 , height: 35 )
    usersName.frame.origin = CGPoint(x: avatarImage.frame.maxX + 8,
                                     y: 8)
    postImage.frame = CGRect(x: 0,
                             y: avatarImage.frame.maxY + 8,
                             width: frame.width,
                             height: frame.width)
    timeStamp.frame.origin = CGPoint(x: avatarImage.frame.maxX + 8,
                                     y: avatarImage.frame.maxY - timeStamp.frame.height)
    likesLabel.frame.origin = CGPoint(x: 15, y: 0)
    likesLabel.center.y = postImage.frame.maxY + 22
   
    likeButton.center.y = likesLabel.center.y
    likeButton.frame.origin.x = frame.maxX - likeButton.frame.width - 15
    commentLabel.frame = CGRect(x: 15, y: postImage.frame.maxY + 44, width: frame.width - 30, height: commentLabel.intrinsicContentSize.height)
    bigLike.center = postImage.center
    commentLabel.sizeToFit()
    
    addSubview(avatarImage)
    addSubview(usersName)
    addSubview(timeStamp)
    addSubview(postImage)
    addSubview(likesLabel)
    addSubview(likeButton)
    addSubview(commentLabel)
    addSubview(bigLike)

    contentView.frame.size.height = commentLabel.frame.maxY
  }
  
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  
  
}
