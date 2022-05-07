//
//  ReplyCell.swift
//  TwitterClone-MVVM-SwiftUI
//
//  Created by Mehdi MMS on 07/05/2022.
//

import SwiftUI

struct ReplyCell: View {
    let tweet: Tweet
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "arrow.right")
                    .foregroundColor(.gray)
                
                Text("replying to")
                    .foregroundColor(.gray)
                
                Text("@\(tweet.replyingTo ?? "")")
                    .foregroundColor(.blue)
            }
            .padding(.leading)
            .font(.system(size: 12))
            
            TweetCell(tweet: tweet)
        }
    }
}

