//
//  NotificationsView.swift
//  TwitterClone-MVVM-SwiftUI
//
//  Created by Mehdi MMS on 10/04/2022.
//

import SwiftUI

struct NotificationsView: View {
    @ObservedObject var viewModel = NotificationViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.notifications) { notification in
                    NotificationCell(notification: notification)
                }
            }.padding()
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}

