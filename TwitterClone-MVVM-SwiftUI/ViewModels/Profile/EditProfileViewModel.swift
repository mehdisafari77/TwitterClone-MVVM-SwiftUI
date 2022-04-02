//
//  EditProfileViewModel.swift
//  TwitterClone-MVVM-SwiftUI
//
//  Created by Mehdi MMS on 01/04/2022.
//

import SwiftUI

class EditProfileViewModel: ObservableObject {
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
}

enum EditProfileOptions: Int, CaseIterable {
    case fullname
    case username
    case bio
    
    var description: String {
        switch self {
        case .fullname: return "Full Name"
        case .username: return "Username"
        case .bio: return "Bio"
        }
    }
    
    func optionValue(user: User) -> String {
        switch self {
        case .fullname: return user.fullname
        case .username: return user.username
        case .bio: return user.bio ?? "Enter your bio"
        }
    }
}


