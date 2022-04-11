//
//  NotificationCell.swift
//  TwitterClone-MVVM-SwiftUI
//
//  Created by Mehdi MMS on 10/04/2022.
//

import SwiftUI
import KingfisherSwiftUI

struct NotificationCell: View {
    let notification: Notification
    
    var body: some View {
        VStack {
            HStack {
                KFImage(URL(string: notification.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())
                
                HStack {
                    Text(notification.username).font(.system(size: 14, weight: .semibold)) +
                        Text(notification.type.notificationText).font(.system(size: 15))
                }.padding(.horizontal, 4)
                
                Spacer()
                                
                if notification.type == .follow {
                    Button(action: {}, label: {
                        Text(notification.userIsFollowed ? "Following" : "Follow")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(Color(.systemBlue))
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .semibold))
                    })
                }
                
            }.padding(.horizontal, 4)
            
            if let tweet = notification.tweet {
                NotificationTweetView(tweet: tweet)
            }
            
            Divider()
        }
    }
}

