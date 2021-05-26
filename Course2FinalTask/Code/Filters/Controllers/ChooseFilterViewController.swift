//import UIKit
//
//class ChooseFilterViewController: UIViewController {
//  
//  lazy var mainImageView: UIImageView = {
//    let imageView = UIImageView()
//    imageView.translatesAutoresizingMaskIntoConstraints = false
//    imageView.frame.size.width = view.frame.width
//    imageView.frame.size.height = imageView.frame.width
//    return imageView
//  }()
//  
//  lazy var filterThumbnails: UICollectionView = {
//    let layout = UICollectionViewFlowLayout()
//    let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
//    guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return collectionView}
//    flowLayout.scrollDirection = .horizontal
//    collectionView.isPagingEnabled = true
//    collectionView.translatesAutoresizingMaskIntoConstraints = false
//    flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
//    return collectionView
//  }()
//
//  lazy var pageControl: UIPageControl = {
//    let control = UIPageControl()
//    control.translatesAutoresizingMaskIntoConstraints = false
//    control.backgroundColor = .systemGray3
//    control.numberOfPages = effectsKeys.count
//    control.frame.size = CGSize(width: filterThumbnails.frame.width, height: 10)
//    return control
//  }()
//  
//  var protectedImage: UIImage?
//  let effectsKeys = ["CISepiaTone",
//                     "CIColorInvert",
//                     "CIGaussianBlur",
//                     "CIVignette",
//                     "CIPixellate",
//                     "CITwirlDistortion"]
//  
//  init(_ image: UIImage) {
//    super.init(nibName: nil, bundle: nil)
//    mainImageView.image = image
//    protectedImage = image
//    view.addSubview(mainImageView)
//    filterThumbnails.frame.size.height = view.frame.height - mainImageView.frame.height - 10
//    filterThumbnails.frame.origin = CGPoint(x: 0, y: mainImageView.frame.maxY)
//    filterThumbnails.backgroundColor = .white
//    filterThumbnails.showsHorizontalScrollIndicator = false
//    view.addSubview(filterThumbnails)
//    filterThumbnails.dataSource = self
//    filterThumbnails.delegate = self
//    filterThumbnails.isScrollEnabled = true
//    filterThumbnails.clipsToBounds = false
//    filterThumbnails.register(FiltersThumbnailCell.self, forCellWithReuseIdentifier: "FiltersThumbnailCell")
//    let tabBarHeight = Router.addImageNavigationController.tabBarController?.tabBar.frame.height
//    pageControl.frame.origin = CGPoint(x: 0, y: filterThumbnails.frame.height + mainImageView.frame.height - (tabBarHeight ?? 0))
//    pageControl.bounds = pageControl.frame
//    view.addSubview(pageControl)
//    title = "New post"
//    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(goToSharePostVC))
//  }
//  
//  override func viewWillLayoutSubviews() {
//    filterThumbnails.frame.size.height -= tabBarController?.tabBar.frame.height ?? 0
//  }
//  
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//  
//  @objc func goToSharePostVC() {
//    guard let image = mainImageView.image else {return}
//    let targetVC = SharePostViewController(image)
//    self.navigationController?.pushViewController(targetVC, animated: true)
//  }
//}
