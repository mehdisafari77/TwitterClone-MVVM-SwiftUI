//
//  FeedView.swift
//  TwitterClone-MVVM-SwiftUI
//
//  Created by Mehdi MMS on 07/05/2022.
//

import SwiftUI

struct FeedView: View {
    @State var isShowingNewTweetView = false
    @ObservedObject var viewModel: FeedViewModel

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.tweets) { tweet in
                        NavigationLink(destination: TweetDetailView(tweet: tweet)) {
                            TweetCell(tweet: tweet)
                        }
                    }
                }.padding()
            }
            
            Button(action: { isShowingNewTweetView.toggle() }, label: {
                Image("tweet")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 28, height: 28)
                    .padding()
            })
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .fullScreenCover(isPresented: $isShowingNewTweetView) {
                NewTweetView(isPresented: $isShowingNewTweetView, tweet: nil)
            }
        }
    }
}
