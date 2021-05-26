//import UIKit
//protocol INetworkEngine {
//  static var isOnline: Bool { get }
//
//  /// Установка состояния онлайн-статуса.
//  /// - Parameter status: Новое состояние статуса.
//  static func setOnlineStatus(to status: Bool)
//
//  /// Получение текущего пользователя.
//  /// - Parameter completion: Замыкание, в которое возвращается текущий пользователь.
//  ///   Вызывается после выполнения запроса.
//  func fetchCurrentUser(completion: @escaping UserResult)
//
//  /// Получение пользователя с указанным ID.
//  /// - Parameters:
//  ///   - userID: ID пользователя.
//  ///   - completion: Замыкание, в которое возвращается запрашиваемый пользователь.
//  ///   Вызывается после выполнения запроса.
//  func fetchUser(withID userID: User.id, completion: @escaping UserResult)
//
//  /// Подписывает текущего пользователя на пользователя с указанным ID.
//  /// - Parameters:
//  ///   - userID: ID пользователя.
//  ///   - completion: Замыкание, в которое возвращается пользователь, на которого подписался текущий пользователь.
//  ///   Вызывается после выполнения запроса.
//  func followToUser(withID userID: UserModel.ID, completion: @escaping UserResult)
//
//  /// Отписывает текущего пользователя от пользователя с указанным ID.
//  /// - Parameters:
//  ///   - userID: ID пользователя.
//  ///   - completion: Замыкание, в которое возвращается пользователь, от которого отписался текущий пользователь.
//  ///   Вызывается после выполнения запроса.
//  func unfollowFromUser(withID userID: UserModel.ID, completion: @escaping UserResult)
//
//  /// Получение всех подписчиков пользователя с указанным ID.
//  /// - Parameters:
//  ///   - userID: ID пользователя.
//  ///   - completion: Замыкание, в которое возвращаются запрашиваемые пользователи.
//  ///   Вызывается после выполнения запроса.
//  func fetchUsersFollowingUser(withID userID: UserModel.ID, completion: @escaping UsersResult)
//
//  /// Получение всех подписок пользователя с указанным ID.
//  /// - Parameters:
//  ///   - userID: ID пользователя.
//  ///   - completion: Замыкание, в которое возвращаются запрашиваемые пользователи.
//  ///   Вызывается после выполнения запроса.
//  func fetchUsersFollowedByUser(withID userID: UserModel.ID, completion: @escaping UsersResult)
//
//  /// Получение публикаций пользователя с указанным ID.
//  /// - Parameters:
//  ///   - userID: ID пользователя.
//  ///   - completion: Замыкание, в которое возвращаются запрашиваемые публикации.
//  ///   Вызывается после выполнения запроса.
//  func fetchPostsOfUser(withID userID: UserModel.ID, completion: @escaping PostsResult)
//
//  /// Получение публикаций пользователей, на которых подписан текущий пользователь.
//  /// - Parameter completion: Замыкание, в которое возвращаются запрашиваемые публикации.
//  ///   Вызывается после выполнения запроса.
//  func fetchFeedPosts(completion: @escaping PostsResult)
//
//  /// Получение публикации с указанным ID.
//  /// - Parameters:
//  ///   - postID: ID публикации.
//  ///   - completion: Замыкание, в которое возвращается запрашиваемая публикация.
//  ///   Вызывается после выполнения запроса.
//  func fetchPost(withID postID: PostModel.ID, completion: @escaping PostResult)
//
//  /// Ставит лайк от текущего пользователя на публикации с указанным ID.
//  /// - Parameters:
//  ///   - postID: ID публикации.
//  ///   - completion: Замыкание, в которое возвращается публикация, которой был поставлен лайк.
//  ///   Вызывается после выполнения запроса.
//  func likePost(withID postID: PostModel.ID, completion: @escaping PostResult)
//
//  /// Удаляет лайк от текущего пользователя на публикации с указанным ID.
//  /// - Parameters:
//  ///   - postID: ID публикации.
//  ///   - completion: Замыкание, в которое возвращается публикация, которой был поставлен анлайк.
//  ///   Вызывается после выполнения запроса.
//  func unlikePost(withID postID: PostModel.ID, completion: @escaping PostResult)
//
//  /// Получение пользователей, поставивших лайк на публикацию с указанным ID.
//  /// - Parameters:
//  ///   - postID: ID публикации.
//  ///   - completion: Замыкание, в которое возвращаются запрашиваемые пользователи.
//  ///   Вызывается после выполнения запроса.
//  func fetchUsersLikedPost(withID postID: PostModel.ID, completion: @escaping UsersResult)
//
//  /// Создание новой публикации.
//  /// - Parameters:
//  ///   - image: Изображение публикации.
//  ///   - description: Описание публикации.
//  ///   - completion: Замыкание, в которое возвращаются опубликованная публикация.
//  ///   Вызывается после выполнения запроса.
//  func createPost(imageData: String, description: String, completion: @escaping PostResult)
//}
//}
////class NetworkEngine {
////
////  var currentUser: User?
////  var tempUser: User?
////  var token: String?
////
////  enum HTTPMethod {
////    case GET, POST
////    var strigifiedMethod: String {
////      switch self {
////      case .GET:
////        return "GET"
////      case .POST:
////        return "POST"
////      }
////    }
////  }
////
////
////  /// Общий и единственный объект класса
////  static var shared: NetworkEngine = {
////    let instance = NetworkEngine()
////    return instance
////  }()
////
////  private init() {}
////
////  //MARK: - Just for fun
////  private func runInMainQueue(block: @escaping () -> ()) {
////    DispatchQueue.main.async {
////      block()
////    }
////  }
////
////  private func constructRequest<T>(for target: Target<T>) -> URLRequest? {
////    var request = URLRequest(url: target.url)
////    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
////    if let token = token {
////      request.setValue(token, forHTTPHeaderField: "token")
////    }
////    switch target {
////    case .feed:
////      return request
////    case .getCurrentUser:
////      return request
////    case let .signIn(_, login, password):
////      let parameters = [
////        "login": login,
////        "password": password
////      ]
////      request.httpMethod = HTTPMethod.POST.strigifiedMethod
////      request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
////    case .findPosts:
////      return request
////    case .userFollowed:
////      return request
////    case .userFollowings:
////      return request
////    case .follow(_, let id):
////      let parameters = [
////        "userID": id
////      ]
////      request.httpMethod = HTTPMethod.POST.strigifiedMethod
////      request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
////    case .unfollow(_, let id):
////      let parameters = [
////        "userID": id
////      ]
////      request.httpMethod = HTTPMethod.POST.strigifiedMethod
////      request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
////    case .uploadPost(_, let image, let description):
////      request.httpMethod = HTTPMethod.POST.strigifiedMethod
////      guard let imageData = image.jpegData(compressionQuality: 1)
////      else { return nil}
////      let base64ImageString = imageData.base64EncodedString()
////      let data = [
////        "image": base64ImageString,
////        "description": description ?? ""
////      ]
////      request.httpBody = try? JSONSerialization.data(withJSONObject: data)
////    case .getUser:
////      return request
////    case .usersLikesSpecificPost:
////      return request
////    case let .likePost(_, postId):
////      let parameters = [
////        "postID": postId
////      ]
////      request.httpMethod = HTTPMethod.POST.strigifiedMethod
////      request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
////    case let .unlikePost(_, postID):
////      let parameters = [
////        "postID": postID
////      ]
////      request.httpMethod = HTTPMethod.POST.strigifiedMethod
////      request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
////    case .signOut:
////      request.httpMethod = HTTPMethod.POST.strigifiedMethod
////      return request
////    }
////    return request
////  }
////
////  private func performRequest<T: Decodable>(for target: Target<T.Type>, completion: @escaping (Result<T?, ErrorHandlingDomain>) -> Void) {
////    guard let request = constructRequest(for: target) else
////    {
////      return
////    }
////    let session = getURLSession()
////    session.dataTask(with: request) { [self] (data, response, error) in
////      if error != nil {
////        if let response = response as? HTTPURLResponse {
////          completion(.failure(.requestError(errorCode: response)))
////        }
////      }
////      guard let data = data else {
////        completion(.failure(.noDataRecieved))
////        return
////      }
////      switch target {
////      case .feed:
////        if let feed = try? decoder.decode(T.self, from: data) {
////          completion(.success(feed))
////        }
////        else {
////          completion(.failure(.parsingFailed))
////        }
////      case .getCurrentUser:
////        if let user = try? JSONDecoder().decode(T.self, from: data) {
////          completion(.success(user))} else {
////            completion(.failure(.tokenExpired))
////          }
////      case .signIn:
////        guard let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
////          completion(.failure(.noTokenParsed))
////          return
////        }
////        if let token = dict["token"] as? String {
////          self.token = token
////          completion(.success(token as? T))
////        } else {
////          completion(.failure(.wrongCredentials))
////        }
////      case .findPosts:
////        if let posts = try? JSONDecoder().decode(T.self, from: data){
////          completion(.success(posts))}
////      case .userFollowings:
////        if let users = try? JSONDecoder().decode(T.self, from: data) {
////          completion(.success(users))
////        }
////      case .userFollowed:
////        if let users = try? JSONDecoder().decode(T.self, from: data) {
////          completion(.success(users))
////        }
////      case .follow:
////        if let user = try? JSONDecoder().decode(T.self, from: data) {
////          completion(.success(user))} else {
////            completion(.failure(.requestError(errorCode: response as! HTTPURLResponse)))
////          }
////      case .unfollow:
////        if let user = try? JSONDecoder().decode(T.self, from: data) {
////          completion(.success(user))} else {
////            completion(.failure(.requestError(errorCode: response as! HTTPURLResponse)))
////          }
////      case .uploadPost:
////        if let post = try? JSONDecoder().decode(T.self, from: data) {
////          completion(.success(post))
////        } else {
////          completion(.failure(.noDataRecieved))
////        }
////      case .getUser:
////        if let user = try? JSONDecoder().decode(T.self, from: data) {
////          completion(.success(user))} else {
////            completion(.failure(.parsingFailed))
////          }
////      case .usersLikesSpecificPost:
////        if let users = try? JSONDecoder().decode(T.self, from: data) {
////          completion(.success(users))
////        } else {
////          completion(.failure(.parsingFailed))
////        }
////      case .likePost:
////        if let post = try? JSONDecoder().decode(T.self, from: data) {
////          completion(.success(post))
////        } else {
////          completion(.failure(.parsingFailed))
////        }
////      case .unlikePost:
////        if let post = try? JSONDecoder().decode(T.self, from: data) {
////          completion(.success(post))
////        } else {
////          completion(.failure(.parsingFailed))
////        }
////      case .signOut:
////        completion(.success(true as? T))
////      }
////    }.resume()
////  }
////
////  //MARK: - Performing login request, if successful - load feed.
////  func loginToServer(login: String, password: String, completion: @escaping (Result<String?, ErrorHandlingDomain>) -> ()) {
////    performRequest(for: .signIn(String.self, login: login, password: password)) {[weak self] result in
////      switch result {
////      case .success(let token):
////        self?.token = token
////        completion(.success(token))
////      case let .failure(error):
////        completion(.failure(error))
////        return
////      }
////    }
////  }
////
////  //MARK: - Loading feed
////  func getFeed(handler:@escaping (Result<[Post], ErrorHandlingDomain>) -> ()) {
////    performRequest(for: .feed([Post].self)) {result in
////      switch result {
////      case .success(let feed):
////        handler(.success(feed!))
////      case .failure(let error):
////        handler(.failure(error))
////      }
////    }
////  }
////
////  //MARK: - Loading model of current user
////  func getCurrentUser(with token: String, handler: @escaping (Result<User?, ErrorHandlingDomain>) -> ()) {
////    self.token = token
////    performRequest(for: .getCurrentUser(User.self)) {[weak self] result in
////      switch result {
////      case .success(let user):
////        self?.currentUser = user
////        handler(.success(user))
////      case .failure(let error):
////        handler(.failure(error))
////      }
////    }
////  }
////
////  //MARK: - Find posts function
////  func findPosts(by: String, handler: @escaping (Result<[Post]?, ErrorHandlingDomain>) -> ()) {
////    performRequest(for: .findPosts([Post].self, by)) {result in
////      switch result {
////      case let .success(posts):
////        handler(.success(posts))
////      case let .failure(error):
////        handler(.failure(error))
////      }
////    }
////  }
////
////  //MARK: - Find followers
////  func usersFollowingUser(with userID: String, handler: @escaping (Result<[User]?, ErrorHandlingDomain>) -> ()) {
////    performRequest(for: .userFollowed([User].self, userID)) {result in
////      switch result {
////      case let .success(users):
////        handler(.success(users))
////      case let .failure(error):
////        handler(.failure(error))
////      }
////    }
////  }
////
////  //MARK: - Find followings
////  func usersFollowedByUser(with userID: String, handler: @escaping (Result<[User]?, ErrorHandlingDomain>) -> ()) {
////    performRequest(for: .userFollowings([User].self, userID)) {result in
////      switch result {
////      case let .success(users):
////        handler(.success(users))
////      case let .failure(error):
////        handler(.failure(error))
////      }
////    }
////  }
////  //MARK: - Follow function
////  func follow(with userID: String, handler: @escaping (Result<User?, ErrorHandlingDomain>) -> ()) {
////    performRequest(for: .follow(User.self, userID)) {result in
////      switch result {
////      case let .success(user):
////        handler(.success(user))
////      case let .failure(error):
////        handler(.failure(error))
////      }
////    }
////  }
////
////  //MARK: - Unfollow function
////  func unfollow(with userID: String, handler: @escaping (Result<User?, ErrorHandlingDomain>) -> ()) {
////    performRequest(for: .unfollow(User.self, userID)) {result in
////      switch result {
////      case let .success(user):
////        handler(.success(user))
////      case let .failure(error):
////        handler(.failure(error))
////      }
////    }
////  }
////
////  //MARK: - Get current user
////  func currentUser(handler: @escaping (Result<User?, ErrorHandlingDomain>) -> ()) {
////    performRequest(for: .getCurrentUser(User.self)) {result in
////      switch result {
////      case let .success(user):
////        self.currentUser = user
////        handler(.success(user))
////      case let .failure(error):
////        handler(.failure(error))
////      }
////    }
////  }
////
////  //MARK: - Upload post
////  func uploadPost(image: UIImage, description: String, handler: @escaping (Result<Post?, ErrorHandlingDomain>) -> ()) {
////    performRequest(for: .uploadPost(Post.self, image: image, description: description)) {result in
////      switch result {
////      case .success(let post):
////        handler(.success(post))
////      case .failure(let error):
////        handler(.failure(error))
////      }
////    }
////  }
////
////  //MARK: - Get user by id
////  func getUser(id: String, handler: @escaping (Result<User?, ErrorHandlingDomain>) -> ()) {
////    performRequest(for: .getUser(User.self, id)) { result in
////      switch result {
////      case let .success(user):
////        handler(.success(user))
////      case let .failure(error):
////        handler(.failure(error))
////      }
////    }
////  }
////
////  //MARK: - Get users liked specific post
////  func usersLikedSpecificPost(postID: String, handler: @escaping (Result<[User]?, ErrorHandlingDomain>) -> ()) {
////    performRequest(for: .usersLikesSpecificPost([User].self, postID: postID)) {result in
////      switch result {
////      case let .success(users):
////        handler(.success(users))
////      case let .failure(error):
////        handler(.failure(error))
////      }
////    }
////  }
////
////  //MARK: - Like post
////  func likePost(postID: String, handler: @escaping (Result<Post?, ErrorHandlingDomain>) -> ()) {
////    performRequest(for: .likePost(Post.self, postID: postID)) {result in
////      switch result {
////      case .success(let post):
////        handler(.success(post))
////      case .failure(let error):
////        handler(.failure(error))
////      }
////    }
////  }
////
////  //MARK: - Unlike post
////  func unlikePost(postID: String, handler: @escaping (Result<Post?, ErrorHandlingDomain>) -> ()) {
////    performRequest(for: .unlikePost(Post.self, postID: postID)) {result in
////      switch result {
////      case .success(let post):
////        handler(.success(post))
////      case .failure(let error):
////        handler(.failure(error))
////      }
////    }
////  }
////
////  //MARK: - Logout func
////  func logOut() {
////    performRequest(for: .signOut(Bool.self)) {_ in
////      self.currentUser = nil
////      self.token = nil
////      KeyChainService.delete(key: "token")
////    }
////  }
////
////  private func getURLSession() -> URLSession {
////    return URLSession(configuration: .default)
////  }
////}
