//import UIKit
//
//
//class ProfilePhotosCell: UICollectionViewCell {
//  
//  private lazy var image: UIImageView = {
//    let imgView = UIImageView()
//    return imgView
//  }()
//  
//  final func configure(post: Post){
//    contentView.clipsToBounds = true
//    image.kf.setImage(with: URL(string: post.image!))
//    image.frame.size = CGSize(width: UIScreen.main.bounds.width/3-1, height: 0 )
//    image.frame.size.height = image.frame.width
//    contentView.frame = image.bounds
//    contentView.addSubview(image)
//  }
//}
