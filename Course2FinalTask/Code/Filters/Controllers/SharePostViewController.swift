//
//  SharePostViewController.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 18.10.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class SharePostViewController: UIViewController {
  
  lazy var postImage: UIImageView = {
    let imageView = UIImageView()
    imageView.frame.size = CGSize(width: 100, height: 100)
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  lazy var textField: UITextField = {
    let textField = UITextField()
    return textField
  }()
  
  init(_ image: UIImage) {
    super.init(nibName: nil, bundle: nil)
    postImage.image = image
    title = "New post"
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain , target: self, action: #selector(sharePost))
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    view.clipsToBounds = true
    view.backgroundColor = .white
    postImage.frame = CGRect(x: 16,
                             y:view.safeAreaInsets.top + 16,
                             width: 100,
                             height: 100)
    view.addSubview(postImage)
    descriptionLabel.text = "Add description"
    descriptionLabel.numberOfLines = 1
    descriptionLabel.sizeToFit()
    descriptionLabel.frame.origin = CGPoint(x: 16,
                                            y: postImage.frame.maxY + 32)
    view.addSubview(descriptionLabel)
    textField.borderStyle = .roundedRect
    textField.frame.origin = CGPoint(x: 16,
                                     y: descriptionLabel.frame.maxY + 8)
    textField.frame.size.width = self.view.frame.width - 32
    textField.frame.size.height = 25
    textField.delegate = self
    view.addSubview(textField)
  }
  
  @objc func sharePost() {
    UIApplication.shared.keyWindow?.lockTheView()
    _ = self.textFieldShouldReturn(textField)
    guard let image = postImage.image,
      let description = textField.text else {return}
    
    DataProviders.shared.postsDataProvider.newPost(with: image, description: description, queue: .global(qos: .userInitiated)) {[weak self] post in
      guard let self = self else {return}
      guard let post = post else {
        self.alert(completion: nil)
        return
      }
       
      DispatchQueue.main.async {
        UIApplication.shared.keyWindow?.unlockTheView()
        self.tabBarController?.selectedIndex = 0
        if let navigationController = self.tabBarController?.selectedViewController as? UINavigationController {
          if let feed = navigationController.viewControllers[0] as? FeedTableViewController {
            feed.feed.insert(post, at: 0)
            feed.tableView.reloadData()
           
            feed.tableView.scrollToRow(at: .init(item: 0, section: 0), at: .top, animated: true)
            self.navigationController?.viewControllers.removeLast(2)
          }
        }
      }
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
