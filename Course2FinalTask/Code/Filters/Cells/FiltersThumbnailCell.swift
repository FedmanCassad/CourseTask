//import UIKit
//
//class FiltersThumbnailCell: UICollectionViewCell {
//  private lazy var thumbnailImage: UIImageView = {
//    return UIImageView()
//  }()
//  
//  private lazy var filterLabel: UILabel = {
//    return UILabel()
//  }()
//  
//  private lazy var gestureRecognizer: UITapGestureRecognizer = {
//    let gr = UITapGestureRecognizer(target: self, action: #selector(applyFilter))
//    return gr
//  }()
//  
//  var filteredImage: UIImage?
//  let intensityConst = 0.5
//  var delegate: FilterCellDelegate?
//  
//  func configure(image: UIImage, filterName: String){
//    let queue = DispatchQueue(label: "Filtering", qos: .utility, attributes: .concurrent)
//    self.thumbnailImage.frame.size = (delegate?.sizeForThumbnailImage())!
//    self.thumbnailImage.contentMode = .scaleAspectFit
//    self.thumbnailImage.center = self.contentView.center
//    self.thumbnailImage.addGestureRecognizer(gestureRecognizer)
//    self.thumbnailImage.isUserInteractionEnabled = true
//    self.addSubview(self.thumbnailImage)
//    self.filterLabel.text = filterName
//    self.filterLabel.sizeToFit()
//    self.filterLabel.center.x = self.thumbnailImage.center.x
//    self.filterLabel.frame.origin.y = self.thumbnailImage.frame.maxY + 8
//    self.addSubview(self.filterLabel)
//    queue.async {[weak self] in
//      guard let self = self else {return}
//      let context = CIContext()
//      guard let preparedImage = CIImage(image: image) else {return}
//      let filter = CIFilter(name: filterName)
//      guard let safeFilter = filter else {return}
//      safeFilter.setValue(preparedImage, forKey: kCIInputImageKey)
//      if safeFilter.inputKeys.contains(kCIInputIntensityKey){ safeFilter.setValue(self.intensityConst, forKey: kCIInputIntensityKey)}
//      if safeFilter.inputKeys.contains(kCIInputRadiusKey) { safeFilter.setValue(self.intensityConst * 100, forKey: kCIInputRadiusKey) }
//      if safeFilter.inputKeys.contains(kCIInputScaleKey) { safeFilter.setValue(self.intensityConst * 25, forKey: kCIInputScaleKey) }
//      if safeFilter.inputKeys.contains(kCIInputCenterKey) { safeFilter.setValue(CIVector(x: image.size.width/2 , y: image.size.height/2), forKey: kCIInputCenterKey) }
//      if let filteredImage = safeFilter.outputImage {
//        if let resultingImage = context.createCGImage(filteredImage, from: filteredImage.extent) {
//          let imageToSet = UIImage(cgImage: resultingImage)
//          DispatchQueue.main.async {
//            self.thumbnailImage.image = imageToSet}
//          self.filteredImage = imageToSet
//        }
//      }
//    }
//  }
//  
//  @objc func applyFilter() {
//    delegate?.applyFilter(filteredImage)
//  }
//}
