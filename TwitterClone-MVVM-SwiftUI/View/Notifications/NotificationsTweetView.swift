//
//  NotificationsTweetView.swift
//  TwitterClone-MVVM-SwiftUI
//
//  Created by Mehdi MMS on 10/04/2022.
//

import SwiftUI
import KingfisherSwiftUI

struct NotificationTweetView: View {
    let tweet: Tweet
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                KFImage(URL(string: tweet.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 24, height: 24)
                    .clipShape(Circle())
                
                Text(tweet.fullname)
                    .font(.system(size: 12, weight: .semibold))
                
                Text("• @\(tweet.username)")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            
            Text(tweet.caption)
                .font(.system(size: 14))
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 3)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
        .padding()
    }
}

