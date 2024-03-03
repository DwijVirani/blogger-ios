//
//  AllBlogs.swift
//  Group2_Blogger
//
//  Created by Harsh Goyal on 14/02/24.
//

import SwiftUI

struct AllBlogs: View {
    @State private var objectList:[Blog] = []
    @State private var searchText:String = ""
    @EnvironmentObject var loggedInUser:User
    @State private var selection = 0
    @State private var pickerOptions: [Group] = []
    @State private var filteredList:[Blog] = []
    var body: some View {
        NavigationStack{
            VStack{
                
//                Spacer()
                HStack{
                    SearchBar(text: $searchText)
                    Picker("Select Option", selection: $selection) {
                        ForEach(0..<loggedInUser.joinedGroup.count) { index in
                            Text(loggedInUser.joinedGroup[index].title).tag(index)
                                        }
                    }
                }
                
                
                List{
                    ForEach(filteredList){item in
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
                                    Text("2024-12-09")
                                    
                                }
                                .foregroundColor(.white)
                                .padding()
                            }
                            
                            
                            
                        }.padding().background(Rectangle().foregroundColor(.green).cornerRadius(10).shadow(radius: 5).padding())
                            .frame(width: 400,height: 150)
                    }.padding()
                }//List
                .listStyle(GroupedListStyle())
                .background(Color.white)
                
            }//VStack
            
            .background(Color.white)
            .onChange(of: selection){
                newValue in
                filteredList = objectList.filter{$0.group.title == loggedInUser.joinedGroup[selection].title}
            }
            .onChange(of: searchText){
                newValue in
                filteredList = filteredList.filter{
                    $0.author == searchText
                }
            }
            .onAppear(){
//
//                objectList.append(blogObject)
//                objectList.append(blogObject1)
//                objectList.append(blogObject2)
//                objectList.append(blogObject4)
                self.loadObjectListFromBlogDefaults()
                filteredList = objectList
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
}


struct SearchBar: View {
    @EnvironmentObject var loggedInUser:User
    @Binding var text: String
//    @State private var selection = 0
//    @State private var pickerOptions: [Group] = []
    

    var body: some View {
        
                
        HStack {
            
            TextField("Search by Author", text: $text)
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


struct AllBlogs_Previews: PreviewProvider {
    static var previews: some View {
        AllBlogs()
    }
}
