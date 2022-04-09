//
//  UploadTweetViewModel.swift
//  TwitterClone-MVVM-SwiftUI
//
//  Created by Mehdi MMS on 09/04/2022.
//

import SwiftUI
import Firebase

enum TweetUploadType {
    case tweet
    case reply(Tweet)
}

class UploadTweetViewModel: ObservableObject {
    @Binding var isPresented: Bool
    var tweet: Tweet?
    let isReply: Bool
    
    init(isPresented: Binding<Bool>, tweet: Tweet?) {
        self._isPresented = isPresented
        self.tweet = tweet
        self.isReply = tweet != nil
    }
    
    var profileImageUrl: URL? {
        guard let urlString = isReply ? tweet?.profileImageUrl : AuthViewModel.shared.user?.profileImageUrl else { return nil }
        return URL(string: urlString)
    }
    
    var placeholderText: String {
        return isReply ? "Tweet your reply..." : "What's happening?"
    }
    
    func uploadTweet(caption: String) {
        if isReply {
            guard let tweet = tweet else { return }
            upload(caption: caption, type: .reply(tweet))
        } else {
            upload(caption: caption, type: .tweet)
        }
    }
        
    private func upload(caption: String, type: TweetUploadType) {
        guard let user = AuthViewModel.shared.user else { return }
        let docRef = documentReference(forUploadType: type)
        
        var data: [String: Any] = ["uid": user.id,
                                   "caption": caption,
                                   "fullname": user.fullname, "timestamp": Timestamp(date: Date()),
                                   "username": user.username,
                                   "profileImageUrl": user.profileImageUrl,
                                   "likes": 0,
                                   "id": docRef.documentID]
        
        switch type {
        case .reply(let tweet):
            data["replyingTo"] = tweet.username
            
            docRef.setData(data) { _ in
                let userRepliesRef = COLLECTION_USERS.document(user.id).collection("user-replies").document(docRef.documentID)
                userRepliesRef.setData(data) { _ in
                    self.isPresented = false
                    NotificationViewModel.uploadNotification(toUid: tweet.uid, type: .reply, tweet: tweet)
                }
            }
        case .tweet:
            docRef.setData(data) { _ in
                self.isPresented = false
            }
        }
    }
    
    private func documentReference(forUploadType type: TweetUploadType) -> DocumentReference {
        let docRef = COLLECTION_TWEETS.document()
        
        switch type {
        case .reply(let tweet):
            return COLLECTION_TWEETS.document(tweet.id).collection("tweet-replies").document(docRef.documentID)
        case .tweet:
            return docRef
        }
    }
}
