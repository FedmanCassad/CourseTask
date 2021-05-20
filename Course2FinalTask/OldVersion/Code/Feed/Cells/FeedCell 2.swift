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
  var post: Post!
  var delegate: CellDelegate?
  
  var doubleTapRecognizer: UITapGestureRecognizer {
    let tchRecg = UITapGestureRecognizer(target: self, action: #selector(userSomeHowTapped(sender:)))
    tchRecg.numberOfTapsRequired = 2
    tchRecg.numberOfTouchesRequired = 1
    return tchRecg
  }
  
  var singleTapRecognizer: UITapGestureRecognizer {
    let tchRecg = UITapGestureRecognizer(target: self, action: #selector(userSomeHowTapped(sender:)))
    tchRecg.numberOfTapsRequired = 1
    tchRecg.numberOfTouchesRequired = 1
    return tchRecg
  }
  
  
  
  //MARK: - Top footer (avatar,nickname,created time)
  private lazy var avatarImage: UIImageView = {
    let img = UIImageView()
    img.contentMode = .scaleAspectFit
    img.addGestureRecognizer(singleTapRecognizer)
    img.gestureRecognizers?[0].name = "avatarTapped"
    img.isUserInteractionEnabled = true
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
  
  private lazy var usersName: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    
    lbl.addGestureRecognizer(singleTapRecognizer)
    lbl.gestureRecognizers?[0].name = "userNameTapped"
    lbl.isUserInteractionEnabled = true
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
    
    imgView.addGestureRecognizer(doubleTapRecognizer)
    imgView.gestureRecognizers?[0].name = "bigPictureDoubleTapped"
    imgView.isUserInteractionEnabled = true
    imgView.translatesAutoresizingMaskIntoConstraints = false
    return imgView
  }()
  
  //MARK: - Footer
  private lazy var likesLabel: UILabel = {
    let lbl = UILabel()
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.addGestureRecognizer(singleTapRecognizer)
    lbl.gestureRecognizers?[0].name = "listOfLikes"
    lbl.isUserInteractionEnabled = true
    return lbl
  }()
  
  private lazy var likeButton: UIButton = {
    let button = UIButton(type: .custom)
    let img = UIImage(named: "like")
    button.setImage(img, for: .normal)
    button.tintColor = .lightGray
    button.sizeToFit()
    button.addGestureRecognizer(singleTapRecognizer)
    button.gestureRecognizers?[0].name = "likeTapped"
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private lazy var commentLabel: UILabel = {
    let lbl = UILabel()
    lbl.numberOfLines = 0
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
  }()
  
  private lazy var bigLike: UIImageView = {
    
    let img = UIImage(named: "bigLike")
    
    let imgView = UIImageView(image: img)
    
    imgView.tintColor = .white
    imgView.translatesAutoresizingMaskIntoConstraints = false
    return imgView
  }()
  
  
  func configure(with post: Post) {
    self.post = post
    //MARK: - Initialising UIs with post data
    frame.size.width = UIScreen.main.bounds.width
    clipsToBounds = true
    avatarImage.image = post.authorAvatar
    usersName.text = post.authorUsername
    let formatter = DateFormatter()
    formatter.timeStyle = .medium
    formatter.dateStyle = .medium
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day,.month, .year], from: post.createdTime)
    let nowComponents = calendar.dateComponents([.day, .month, .year], from: Date())
    let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: post.createdTime)
    let time = calendar.date(from: timeComponents)
    if components == nowComponents {
      formatter.dateStyle = .none
      timeStamp.text = "Today at \(formatter.string(from: time!))"
    } else {
      timeStamp.text = formatter.string(from: post.createdTime)
    }
    postImage.image = post.image
    likesLabel.text = "Likes: \(post.likedByCount)"
    commentLabel.text = post.description
    if post.currentUserLikesThisPost {
      likeButton.isSelected = true
      likeButton.tintColor = .systemBlue
    }
    configureLayout()
  }
  
  private func configureLayout () {
    commentLabel.sizeToFit()
    likesLabel.sizeToFit()
    usersName.sizeToFit()
    timeStamp.sizeToFit()
    
    //MARK: - Configuring layout by frames
    // Прошу обратить внимание, в рецензии к последней работе преподаватель попросил меня сверстать в следующем задании макет констрейтами, но к этой просьбе я испытываю внутреннее сопротивление, потому что как было сказанно в лекции, да с кодом заморачивать чуть дольше чем с констрейтами, но при запуске верстка фреймами исполняется раза в 4 быстрее. Поэтому мне бы хотелось сделать "правильно". С autolayout я знаю как работать и домашней работы по нему было достаточно, теперь хочется ручками поделать. Извините.
    avatarImage.frame = CGRect(x: 15,
                               y: 8,
                               width: 35,
                               height: 35)
    usersName.frame.origin = CGPoint(x: avatarImage.frame.maxX + 8,
                                     y: 8)
    postImage.frame = CGRect(x: 0,
                             y: avatarImage.frame.maxY + 8,
                             width: frame.width,
                             height: frame.width)
    timeStamp.frame.origin = CGPoint(x: avatarImage.frame.maxX + 8,
                                     y: avatarImage.frame.maxY - timeStamp.frame.height)
    likesLabel.frame.origin = CGPoint(x: 15,
                                      y: 0)
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
    contentView.frame.size.height = commentLabel.frame.maxY
  }
  
  //MARK: - Actions
  @objc func userSomeHowTapped(sender: UITapGestureRecognizer) {
    switch sender.name {
      case "bigPictureDoubleTapped":
        animateLike()
        likeTapped()
      case "avatarTapped":
        goToProfile()
      case "userNameTapped":
        goToProfile()
      case "likeTapped":
        likeTapped()
      case "listOfLikes":
        goToListView()
      default:
       return
    }
  }
  
  func animateLike() {
    bigLike.layer.opacity = 0
    addSubview(bigLike)
    let animator = CAKeyframeAnimation(keyPath: "opacity")
    animator.values = [0,1,1,0]
    animator.keyTimes  = [0, 0.1, 0.2, 0.3]
    animator.duration = 9
    animator.isAdditive = true
    animator.timingFunction = CAMediaTimingFunction(controlPoints: 0.15, 1, 0.85, 0)
    bigLike.layer.add(animator, forKey: "opacity")
  }
  
  func goToListView() {
    guard let userIds =  postsData.usersLikedPost(with: post.id) else {return}
    var users = Array<User>()
    userIds.forEach({userID in
      guard let user = usersData.user(with: userID) else {return}
      users.append(user)
    })
    delegate?.goToProfilesList(users: users, .follows)
  }
  
  func goToProfile() {
    let user = usersData.user(with: post.author)
    delegate?.goToSelectedProfile(user: user!)
  }
  
  func likeTapped() {
    if !likeButton.isSelected {
      likeButton.isSelected = true
      likeButton.tintColor = .systemBlue
      post.currentUserLikesThisPost = postsData.likePost(with: post.id)
      post = postsData.post(with: post.id)
      likesLabel.text = "Likes: \(post.likedByCount)"
      likesLabel.sizeToFit()
    } else {
      likeButton.isSelected = false
      likeButton.tintColor = .lightGray
      post.currentUserLikesThisPost = !postsData.unlikePost(with: post.id)
      post = postsData.post(with: post.id)
      likesLabel.text = "Likes: \(post.likedByCount)"
      likesLabel.sizeToFit()
    }
  }
  
}

