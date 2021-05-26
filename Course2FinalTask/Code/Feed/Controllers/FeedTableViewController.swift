//import UIKit
//
//class FeedTableViewController: UIViewController {
//  let dataProvider: CoreDataService
//  var feed: [Post]
//  let tableView = UITableView()
//  
//  init(feed: [Post], dataProvider: CoreDataService) {
//    self.dataProvider = dataProvider
//    self.feed = feed
//    super.init(nibName: nil, bundle: nil)
//  }
//  
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//  //MARK: - Lifecycle
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    tableView.translatesAutoresizingMaskIntoConstraints = false
//    tableView.frame = UIScreen.main.bounds
//    view.addSubview(tableView)
//    tableView.delegate = self
//    tableView.dataSource = self
//    tableView.register(FeedCell.self, forCellReuseIdentifier: "FeedCell")
//    tableView.separatorStyle = .none
//    tableView.allowsSelection = false
//    title = "Feed"
//    let anotherFeed = dataProvider.fetchData(for: ManagedPost.self)
//    print(anotherFeed?.count)
////    anotherFeed?.forEach {
////      dataProvider.deleteObject(object: $0)
////    }
//  }
//}
