import Foundation

struct User: Codable, Identifiable {
  var id, username, fullName, avatar: String
  var currentUserFollowsThisUser, currentUserIsFollowedByThisUser: Bool
  var followsCount, followedByCount: Int
}

