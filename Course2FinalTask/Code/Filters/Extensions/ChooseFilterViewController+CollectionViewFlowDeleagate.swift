//import UIKit
//
//extension ChooseFilterViewController: UICollectionViewDelegateFlowLayout {
//  
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    return collectionView.frame.size
//  }
//
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//    return 0
//  }
//
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//    0
//  }
//  
//  func scrollViewDidScroll(_ scrollView: UIScrollView) {
//    let visibleRect = CGRect(origin: scrollView.contentOffset, size: filterThumbnails.bounds.size)
//    let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
//    if let visibleIndexPath = filterThumbnails.indexPathForItem(at: visiblePoint) {
//      pageControl.currentPage = visibleIndexPath.item
//    }
//  }
//}
