//import UIKit
//
//extension FollowersFollowsTableViewController: UITableViewDelegate {
//    
//  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//      let cell = FollowsCell()
//      cell.configure(user: listOfUsers[indexPath.row])
//      return cell.contentView.frame.maxY + 1
//    }
//  
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//      guard let cell =  tableView.cellForRow(at: indexPath) as? FollowsCell else {return}
//       Router.window?.lockTheView()
//      goToSelectedProfile(user: cell.user)
//    }
//}
