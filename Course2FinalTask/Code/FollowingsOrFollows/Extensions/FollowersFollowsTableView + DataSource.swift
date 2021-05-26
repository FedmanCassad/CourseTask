//import UIKit
//
//extension FollowersFollowsTableViewController: UITableViewDataSource {
//  
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return listOfUsers.count
//  }
//  
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//      let cell = tableView.dequeueReusableCell(withIdentifier: "FollowsCell", for: indexPath) as! FollowsCell
//      cell.configure(user: listOfUsers[indexPath.row])
//      cell.delegate = self
//  
//      return cell
//    }
//}
