//
//  SharePostViewController.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 18.10.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit

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
     Router.window?.lockTheView()
    _ = self.textFieldShouldReturn(textField)
    guard let image = postImage.image,
          let description = textField.text else {return}
    
    NetworkEngine.shared.uploadPost(image: image, description: description) {[weak self] result in
      guard let self = self else {return}
      switch result {
        case .failure(let error):
          self.alert(error: error)
        case .success(let post):
          if let post = post {
            DispatchQueue.main.async {
             Router.window?.unlockTheView()
              Router.updateFeedIfNeeded(with: post)
            }
          }
      }
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
