//import UIKit
//
//extension ChooseFilterViewController: UICollectionViewDataSource {
//  
//  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return effectsKeys.count
//  }
//  
//  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FiltersThumbnailCell", for: indexPath) as! FiltersThumbnailCell
//    guard let image = protectedImage else { return cell }
//    cell.delegate = self
//    cell.configure(image: image, filterName: effectsKeys[indexPath.item])
//    return cell
//  }
//}
