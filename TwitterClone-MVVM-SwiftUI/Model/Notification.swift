//
//  Notification.swift
//  TwitterClone-MVVM-SwiftUI
//
//  Created by Mehdi MMS on 19/03/2022.
//

import SwiftUI

struct Notification: Identifiable {
    let id: String
    let uid: String
    let username: String
    let profileImageUrl: String
    let type: NotificationType
    var tweetId: String?
    var tweet: Tweet?
    var userIsFollowed = false
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.type = NotificationType(rawValue: dictionary["type"] as? Int ?? 0) ?? .like
        
        if let tweetId = dictionary["tweetId"] as? String {
            self.tweetId = tweetId
        }
    }
}

enum NotificationType: Int {
    case like
    case reply
    case follow
    
    var notificationText: String {
        switch self {
        case .like: return " liked one of your tweets"
        case .reply: return " replied to one of your tweets"
        case .follow: return " started following you"
        }
    }
}
