//
//  SideMenuOptionView.swift
//  TwitterClone-MVVM-SwiftUI
//
//  Created by Mehdi MMS on 30/03/2022.
//

import SwiftUI

struct SideMenuOptionView: View {
    let option: SideMenuViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: option.imageName)
                .foregroundColor(.gray)
                .font(.system(size: 24))

            Text(option.description)
                .foregroundColor(.black)

            Spacer()
        }
    }
}
