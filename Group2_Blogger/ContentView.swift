//
//  ContentView.swift
//  Group2_Blogger
//
//  Created by Harsh Goyal on 14/02/24.
//

import SwiftUI

struct ContentView: View {
    private let fireDBHelper = FirebaseDBHelper.getInstance()
    var fireAuthHelper = FirebaseeAuthHelper()
    
    var body: some View {
        NavigationStack{
            Login()
                .navigationBarTitleDisplayMode(.inline)
                .environmentObject(self.fireDBHelper)
                .environmentObject(self.fireAuthHelper)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
