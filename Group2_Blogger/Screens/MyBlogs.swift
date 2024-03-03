//
//  MyBlogs.swift
//  Group2_Blogger
//
//  Created by Harsh Goyal on 14/02/24.
//

import SwiftUI

struct MyBlogs: View {
    @State private var searchText:String = ""
    @State private var objectList:[Blog] = []
    @EnvironmentObject var loggedInUser:User
    @State private var userBlogs:[Blog] = []
    @State private var selection = 0
    @State private var pickerOptions: [Group] = []
    @State private var filteredList:[Blog] = []
    
    var body: some View {
        NavigationView{
            VStack{
                
                
//                Spacer()
                HStack{
                    SearchBarMyBlogs(text: $searchText)
                    Picker("Select Option", selection: $selection) {
                        ForEach(0..<loggedInUser.joinedGroup.count) { index in
                            Text(loggedInUser.joinedGroup[index].title).tag(index)
                            }
                    }
                    
                
                }
                
                List{
                    ForEach(filteredList){item in
                        NavigationLink(destination: UserBlogDescription(item: item)){
                            ZStack{
                                Image("images")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(height: 150)
                                                .clipped()
                                VStack{
                                    Spacer()
                                    HStack{
                                        VStack(alignment: .leading){
                                            Text(item.author).font(.title2)//Author name
                                            Text(item.title).font(.caption2)
                                        }
                                        
                                            
                                        Spacer()
                                        Text(item.datePosted)
                                        
                                    }
                                    .foregroundColor(.white)
                                    .padding()
                                }
                                
                                
                                
                            }.padding().background(Rectangle().foregroundColor(.green).cornerRadius(10).shadow(radius: 5).padding())
                                .frame(width: 400,height: 150)
                        }.padding()
                        }
                        
                }//List
                .listStyle(GroupedListStyle())
                .background(Color.white)
                
            }
                .background(Color.white)
                .onChange(of: selection) { newValue in


                    filteredList = userBlogs.filter { $0.group.title == loggedInUser.joinedGroup[selection].title }
                }
                .onChange(of: searchText){
                    newValue in
                    if !(searchText == ""){
                        filteredList = filteredList.filter{$0.author == searchText}
                    }
                }
                    .onAppear(){
            //
            //                objectList.append(blogObject)
            //                objectList.append(blogObject1)
            //                objectList.append(blogObject2)
            //                objectList.append(blogObject4)
                        self.loadObjectListFromBlogDefaults()
                        userBlogs = objectList.filter { $0.authorObject.email == loggedInUser.email }
                        filteredList = userBlogs.filter { $0.group.title == loggedInUser.joinedGroup[selection].title }
                        print("***********************************************")
                        print(filteredList)
                        print(userBlogs)
                        print(objectList[0].authorObject.email)
                        print(loggedInUser.email)
                        //            pickerOptions = loggedInUser.joinedGroup
                        
                        
                    }
                    
                    .navigationBarTitleDisplayMode(.inline)
                    
                    .padding()
        }
    
    
    }
    func loadObjectListFromBlogDefaults() {
            if let savedObjectListData = UserDefaults.standard.data(forKey: "Blogs") {
                do {
                    let decoder = JSONDecoder()
                    objectList = try decoder.decode([Blog].self, from: savedObjectListData)
                    
                    print(objectList)
                } catch {
                    print("Error decoding object list: \(error.localizedDescription)")
                }
            } else {
                print("UserDefaults key 'objectListKey' is empty.")
            }
        }
    
//    func filterUserBlogs(){
//        objectList
//    }
}


struct SearchBarMyBlogs: View {
    @EnvironmentObject var loggedInUser:User
    @Binding var text: String
//    @State private var selection = 0
//    @State private var pickerOptions: [Group] = []
    

    var body: some View {
        
                
        HStack {
            
            TextField("Search by title", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .overlay(
                    HStack {
                        Text("")
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if !text.isEmpty {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                                Text("")
                            }
                        }
                    }
                )
                .padding(.horizontal, 3)
//            Picker("Select Option", selection: $selection) {
//                ForEach(0..<loggedInUser.joinedGroup.count) { index in
//                    Text(loggedInUser.joinedGroup[index].title).tag(index)
//                                }
//            }
            
        }.onAppear(){
//            pickerOptions = loggedInUser.joinedGroup
//            print("))))))))))))))))))))))))))))))))))))))")
//            print(loggedInUser.joinedGroup)
        }
    }
}


struct MyBlogs_Previews: PreviewProvider {
    static var previews: some View {
        MyBlogs()
    }
}
