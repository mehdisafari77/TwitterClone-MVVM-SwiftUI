//
//  ProfileViewModel.swift
//  TwitterClone-MVVM-SwiftUI
//
//  Created by Mehdi MMS on 01/04/2022.
//

import SwiftUI
import Firebase

class ProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var userTweets = [Tweet]()
    @Published var likedTweets = [Tweet]()
    @Published var replies = [Tweet]()
    
    init(user: User) {
        self.user = user
        checkIfUserIsFollowed()
        fetchUserTweets()
        fetchLikedTweets()
        fetchUserStats()
        fetchReplies()
    }
        
    func tweets(forFilter filter: TweetFilterOptions) -> [Tweet] {
        switch filter {
        case .tweets: return userTweets
        case .likes: return likedTweets
        case .replies: return replies
        }
    }
}
