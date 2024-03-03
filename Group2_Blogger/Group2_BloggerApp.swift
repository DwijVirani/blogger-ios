//
//  Group2_BloggerApp.swift
//  Group2_Blogger
//
//  Created by Harsh Goyal on 14/02/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

@main
struct Group2_BloggerApp: App {
    var loggedInUser: User = User()
    
    init(){
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(loggedInUser)
                .environmentObject(AllUsers())
        }
    }
}
