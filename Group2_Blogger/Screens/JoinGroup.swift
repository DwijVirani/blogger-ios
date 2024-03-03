//
//  JoinGroup.swift
//  Group2_Blogger
//
//  Created by Harsh Goyal on 15/02/24.
//

import SwiftUI

struct JoinGroup: View {
    @State private var objectList:[Group] = []
        @State private var searchText:String = ""
        var body: some View {
            VStack{
                Spacer()
                SearchBarGroup(text: $searchText)
                List{
                    ForEach(objectList){item in
                        ZStack{
                            
                            VStack{
                                //                            Spacer()
                                HStack{
                                    VStack(alignment: .leading){
                                        Text(item.title).font(.title2)
                                        Text(item.description).font(.caption2)
                                    }
                                    
                                    Spacer()
                                    Button{
                                        if let userData = UserDefaults.standard.data(forKey: "userData") {
                                            if let user = try? JSONDecoder().decode(User.self, from: userData) {
                                                user.joinedGroup.append(item)
                                                print("Joined Group\(user.joinedGroup)")
                                                
                                                if let encodedData = try? JSONEncoder().encode(user) {
                                                    UserDefaults.standard.set(encodedData, forKey: "userData")
                                                }
                                            }
                                        }
                                    }label: {
                                        Text("Join")
                                    }
                                }
                                .foregroundColor(.white)
                                .padding()
                            }
                            
                            
                            
                        }.padding().background(Rectangle().foregroundColor(.green).cornerRadius(10).shadow(radius: 5).padding())
                            .frame(width: 400,height: 35)
                    }.padding()
                }//List
                .listStyle(GroupedListStyle())
                .background(Color.white)
                
            }//VStack
            
            .background(Color.white)
            .onAppear(){
                self.loadObjectListFromBlogDefaults()
            }
            .navigationTitle("Group")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            
        }
        func loadObjectListFromBlogDefaults() {
            if let savedObjectListData = UserDefaults.standard.data(forKey: "groupList") {
                do {
                    let decoder = JSONDecoder()
                    objectList = try decoder.decode([Group].self, from: savedObjectListData)
                    
    //                print(objectList)
                } catch {
                    print("Error decoding object list: \(error.localizedDescription)")
                }
            } else {
                print("UserDefaults key 'objectListKey' is empty.")
            }
        }
    }

    struct SearchBarGroup: View {
        @Binding var text: String
        
        var body: some View {
            
            
            HStack {
                
                TextField("Search", text: $text)
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
            }
        }
}

struct JoinGroup_Previews: PreviewProvider {
    static var previews: some View {
        JoinGroup()
    }
}
