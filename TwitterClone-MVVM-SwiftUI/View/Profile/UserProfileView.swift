//
//  UserProfileView.swift
//  TwitterClone-MVVM-SwiftUI
//
//  Created by Mehdi MMS on 29/06/2022.
//

import SwiftUI

struct UserProfileView: View {
    private let user: User
    @ObservedObject private var viewModel: ProfileViewModel
    @State private var selectedFilter: TweetFilterOptions = .tweets
    @State private var editProfilePresented = false
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ProfileHeaderView(viewModel: viewModel, editProfilePresented: $editProfilePresented)
                    .padding()
                                
                FilterButtonView(selectedOption: $selectedFilter)
                    .padding()
                
                ForEach(viewModel.tweets(forFilter: selectedFilter)) { tweet in
                    if selectedFilter == .replies {
                        ReplyCell(tweet: tweet)
                            .padding()
                    } else {
                        TweetCell(tweet: tweet)
                            .padding()
                    }
                }
            }
            .animation(.spring())
            .transition(.move(edge: .leading))
            
            .navigationTitle(user.username)
        }
    }
}
