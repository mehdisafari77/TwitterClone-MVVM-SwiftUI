//
//  NotificationViewModel.swift
//  TwitterClone-MVVM-SwiftUI
//
//  Created by Mehdi MMS on 31/03/2022.
//

import Firebase

class NotificationViewModel: ObservableObject {
    @Published var notifications = [Notification]()
    
    init() {
        fetchNotifications()
    }
    
    static func uploadNotification(toUid uid: String, type: NotificationType, tweet: Tweet? = nil) {
        guard let currentUser = AuthViewModel.shared.user else { return }
        guard uid != currentUser.id else { return }
        
        let docRef = COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").document()
        
        var data: [String: Any] = ["timestamp": Timestamp(date: Date()),
                                   "uid": currentUser.id,
                                   "type": type.rawValue,
                                   "id": docRef.documentID,
                                   "profileImageUrl": currentUser.profileImageUrl,
                                   "username": currentUser.username]
        
        if let tweet = tweet {
            data["tweetId"] = tweet.id
        }
        
        docRef.setData(data)
    }
    
    static func deleteNotification(toUid uid: String, type: NotificationType, tweetId: String? = nil) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications")
            .whereField("uid", isEqualTo: currentUid).getDocuments { snapshot, _ in
                snapshot?.documents.forEach({ document in
                    let notification = Notification(dictionary: document.data())
                    guard notification.type == type else { return }
                    
                    if tweetId != nil {
                        guard tweetId == notification.tweetId else { return }
                    }
                    
                    document.reference.delete()
                })
            }
    }
    
    func fetchNotifications() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications")
            .order(by: "timestamp", descending: true)
        
        query.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.notifications = documents.map({ Notification(dictionary: $0.data()) })
            
            self.fetchNotificationTweets()
            self.checkIfUserIsFollowed()
        }
    }
    
    func checkIfUserIsFollowed() {
        let followNotifications = notifications.filter({ $0.type == .follow })
        
        followNotifications.forEach { notification in
            UserService.checkIfUserIsFollowed(uid: notification.uid) { isFollowed in
                
                if let index = self.notifications.firstIndex(where: { $0.id == notification.id }) {
                    self.notifications[index].userIsFollowed = isFollowed
                }
            }
        }
    }
