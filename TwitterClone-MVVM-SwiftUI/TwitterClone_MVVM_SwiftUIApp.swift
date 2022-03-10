//
//  TwitterClone_MVVM_SwiftUIApp.swift
//  TwitterClone-MVVM-SwiftUI
//
//  Created by Mehdi MMS on 10/03/2022.
//

import SwiftUI
import Firebase

@main
struct TwitterClone_MVVM_SwiftUIApp: App {

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
