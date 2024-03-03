//
//  Home.swift
//  Group2_Blogger
//
//  Created by Harsh Goyal on 14/02/24.
//

import SwiftUI

enum Tab {
    case myBlogs
    case allBlogs
    case createGroup
    case joingroup
}

struct Home: View {
    @State private var blogObject : Blog = Blog()
    @State private var blogObject1 : Blog = Blog()
    @State private var blogObject2 : Blog = Blog()
    @State private var blogObject4 : Blog = Blog()
    @EnvironmentObject var loggedInUser:User
    @State private var selectedTab: Tab = .myBlogs
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    
    
    var body: some View {
        
        NavigationView {
            
                
            TabView(selection: $selectedTab) {
                MyBlogs()
                    .tabItem {
                        Image(systemName: "book")
                        Text("My-Blogs")
                    }
                    .tag(Tab.myBlogs)
                
                AllBlogs()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("All-Blogs")
                    }
                    .tag(Tab.allBlogs)
                CreateGroup()
                    .tabItem {
                        Image(systemName: "plus")
                        Text("Create-Group")
                    }
                    .tag(Tab.createGroup)
                JoinGroup()
                    .tabItem {
                        Image(systemName: "plus")
                        Text("Join-Group")
                    }
                    .tag(Tab.joingroup)
                    
            }
            //                .navigationTitle(tabTitle())
        }.toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                HStack{
                    NavigationLink(destination: PostBlog()){
                        Text("PostBlog")
                    }
                    
                    Text("")
                    Button{
                        presentationMode.wrappedValue.dismiss()
                    }label: {
                        Text("SignOut").padding(.horizontal,15).padding(.vertical,5)
                    }.foregroundColor(.white).background(Color.red).cornerRadius(7)
//                    NavigationLink(destination: EmptyView()){
//                        Text("SignOut").padding(.horizontal,15).padding(.vertical,5).foregroundColor(.white).background(Rectangle().foregroundColor(.red).cornerRadius(5))
//                    }
//                    Button{
//
//                    }label:{
//                        Image(systemName: "magnifyingglass")
//                            .foregroundColor(.white)
//                            .background(Circle().foregroundColor(Color("Gradient")).frame(width: 50, height: 45))
//                    }
                }
                
                
            }
            
        }.navigationBarBackButtonHidden(true)
        
        
        
    }//body
    
//    func
    
    
}



struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
