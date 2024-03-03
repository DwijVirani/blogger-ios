//
//  PostBlog.swift
//  Group2_Blogger
//
//  Created by Harsh Goyal on 14/02/24.
//

import SwiftUI

struct PostBlog: View {
    @State private var imageName:String = ""
    @State private var postMessage:String = ""
    @State private var title:String = ""
    @State private var showAlert = false
    @State var penName:String = ""
    @State private var objectList: [Blog] = []
    @State private var blogObject : Blog = Blog()
    @State private var linkSelection : Int? = nil
    @State private var datePosted: Date = Date()
    @State private var dateString = ""
    @State private var selectedGroupIndex = 0
    @EnvironmentObject var loggedInUser:User
    
//    @State private var loggedInUser = User()
    @State private var testGroup = Group()
    
    
    
    
    let dateFormatter = DateFormatter()
    var body: some View {
        VStack{
            NavigationLink(destination: Home(), tag: 1, selection: self.$linkSelection){}
            NavigationLink(destination: Signup(), tag: 2, selection: self.$linkSelection){}
            
            Spacer(minLength: 100)
            Text("PostBlog").foregroundColor(.white).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.title)
            Form{
                Section{
                    HStack{
                        TextField("Image:", text: $imageName)
                        Picker("Group :", selection: $selectedGroupIndex) {
                            ForEach(0..<loggedInUser.joinedGroup.count) { index in
                                Text(self.loggedInUser.joinedGroup[index].title).tag(index)
                                        }
                        }
                    }
                    
                }
                
                
                Section{
                    VStack{
                        Text("")
                        TextField("Pen-Name", text: $penName)
                        Text("")
                        Divider()
                        TextField("Title", text: $title)
                        Text("")
                        Divider()
                        Text("")
                        TextField("Enter Blog content here", text: $postMessage,axis: .vertical)
                        Spacer()
                        
                        
                    }.frame(minHeight: 300)
                }
                
                Button{
                    
                    if !title.isEmpty && !imageName.isEmpty && !postMessage.isEmpty && !penName.isEmpty  {
                        self.loadObjectListFromBlogDefaults()
                        self.blogObject.author = penName
                        self.blogObject.content = postMessage
                        self.blogObject.imageName = imageName
                        self.blogObject.title = title
                        self.blogObject.group = Group()
                        self.blogObject.group.title = self.loggedInUser.joinedGroup[selectedGroupIndex].title
                        self.blogObject.authorObject = loggedInUser
                        
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        self.dateString = dateFormatter.string(from: datePosted)
                        self.blogObject.datePosted = dateString
                        
                        objectList.append(blogObject)
    //                    print(objectList)
                        
                        self.saveObjectListToBlogDefaults()
                    } else {
                        // Perform the operation
                        showAlert = true
                    }
                    
                    
                    
                }label: {
                    Text("Post Blog")
                }.frame(maxWidth:.greatestFiniteMagnitude).foregroundColor(.red)
                
            }.alert(isPresented: $showAlert) {
                Alert(title: Text("Missing Information"), message: Text("Please provide all required information."), dismissButton: .default(Text("OK")))
            }
        }.background(LinearGradient(colors: [Color("Gradient"),Color("Gradient1")], startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(maxHeight: .infinity)
        
            .scrollContentBackground(.hidden)
            .onAppear(){
//                testGroup.title = "test"
//                loggedInUser.joinedGroup.append(testGroup)
            }
        
    }
    func loadObjectListFromBlogDefaults() {
            if let savedObjectListData = UserDefaults.standard.data(forKey: "Blogs") {
                do {
                    let decoder = JSONDecoder()
                    objectList = try decoder.decode([Blog].self, from: savedObjectListData)
                    print("+++++++++++++++++")
                    print(objectList)
                } catch {
                    print("Error decoding object list: \(error.localizedDescription)")
                    
                }
            } else {
                print("UserDefaults key 'objectListKey' is empty.")
            }
        }
    func saveObjectListToBlogDefaults() {
            do {
                let encoder = JSONEncoder()
                let encoded = try encoder.encode(objectList)
//                print(encoded)
                
                print("success")
                UserDefaults.standard.set(encoded, forKey: "Blogs")
                
//                linkSelection = 1
            } catch {
                print("Error encoding object list: \(error.localizedDescription)")
            }
        }
}

struct PostBlog_Previews: PreviewProvider {
    static var previews: some View {
        PostBlog()
    }
}
