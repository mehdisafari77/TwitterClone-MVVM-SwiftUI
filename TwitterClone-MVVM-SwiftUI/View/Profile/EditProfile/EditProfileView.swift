//
//  EditProfileView.swift
//  TwitterClone-MVVM-SwiftUI
//
//  Created by Mehdi MMS on 07/05/2022.
//

import SwiftUI
import KingfisherSwiftUI

struct EditProfileView: View {
    @Binding var isShowing: Bool
    @ObservedObject var viewModel: EditProfileViewModel
    let user: User
    
    init(isShowing: Binding<Bool>, user: User) {
        self._isShowing = isShowing
        self.user = user
        self.viewModel = EditProfileViewModel(user: user)
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { isShowing.toggle() }, label: {
                    Text("Cancel")
                        .foregroundColor(.blue)
                        .font(.system(size: 16, weight: .semibold))
                })
                
                Spacer()
                                
                Text("Edit Profile")
                    .font(.system(size: 18, weight: .semibold))
                
                Spacer()
                
                Button(action: { }, label: {
                    Text("Done")
                        .foregroundColor(.blue)
                        .font(.system(size: 16, weight: .semibold))
                })
            }
            .padding()
            
            VStack(spacing: 20) {
                KFImage(URL(string: user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 128, height: 128)
                    .clipShape(Circle())
                    .padding(.top)
                
                Button(action: {}, label: {
                    Text("Change Profile Photo")
                        .font(.system(size: 14, weight: .semibold))
                })
            }
            .frame(width: UIScreen.main.bounds.width, height: 240)
            .background(Color(.systemGray5))
            .padding(.bottom)
            
            
            ForEach(EditProfileOptions.allCases, id: \.self) { option in
                VStack {
                    HStack(alignment: .center, spacing: 64) {
                        Text(option.description)
                            .font(.system(size: 14, weight: .semibold))
                            .frame(width: 100)
                        
                        Text(option.optionValue(user: user))
                            .font(.system(size: 15))
                            .foregroundColor(.blue)
                        Spacer()
                        
                    }
                    .padding(.top, -16)
                    Divider()
                }
            }.padding()
            
            Spacer()
        }
    }
}
