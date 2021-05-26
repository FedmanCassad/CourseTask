//import UIKit
//
//extension FeedTableViewController: UITableViewDelegate {
//  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    //Вроде не самая лучшая идея для динамической высоты ячейки в зависимости от контента, но утечек вроде нет, ячейка сразу уничтожается...
//    let cell = FeedCell()
//    cell.configure(with: feed[indexPath.row])
//    let height = cell.contentView.frame.maxY
//    return height
//  }
//}
