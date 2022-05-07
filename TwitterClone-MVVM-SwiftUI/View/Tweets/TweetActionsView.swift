//
//  TweetActionsView.swift
//  TwitterClone-MVVM-SwiftUI
//
//  Created by Mehdi MMS on 07/05/2022.
//

import SwiftUI

struct TweetActionsView: View {
    let tweet: Tweet
    @State var isShowingReplyView = false
    @ObservedObject var viewModel: TweetActionViewModel
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.viewModel = TweetActionViewModel(tweet: tweet)
    }
    
    var body: some View {
        HStack {
            Button(action: { self.isShowingReplyView.toggle() }, label: {
                Image(systemName: "bubble.left")
                    .font(.system(size: 16))
                    .frame(width: 32, height: 32)
            }).sheet(isPresented: $isShowingReplyView, content: {
                NewTweetView(isPresented: $isShowingReplyView, tweet: tweet)
            })
            
            Spacer()
            
            Button(action: {}, label: {
                Image(systemName: "arrow.2.squarepath")
                    .font(.system(size: 16))
                    .frame(width: 32, height: 32)
            })
            
            Spacer()
            
            Button(action: {
                viewModel.didLike ? viewModel.unlikeTweet() : viewModel.likeTweet()
            }, label: {
                Image(systemName: viewModel.didLike ? "heart.fill" : "heart")
                    .font(.system(size: 16))
                    .frame(width: 32, height: 32)
                    .foregroundColor(viewModel.didLike ? .red : .gray)
            })
            
            Spacer()
            
            Button(action: {}, label: {
                Image(systemName: "bookmark")
                    .font(.system(size: 16))
                    .frame(width: 32, height: 32)
            })
        }
        .foregroundColor(.gray)
        .padding(.horizontal)

    }
}
