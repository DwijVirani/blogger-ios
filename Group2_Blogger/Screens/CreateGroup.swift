//
//  CreateGroup.swift
//  Group2_Blogger
//
//  Created by Harsh Goyal on 14/02/24.
//

import SwiftUI

struct CreateGroup: View {
    @EnvironmentObject var allUsers : AllUsers
    @EnvironmentObject var loggedInUser : User

    @State private var groupTitle: String = ""
    @State private var groupDescription: String = ""
    @State private var groupOwner: User = User()
    @State private var groupMembers: [String] = []
    @State private var groupObj: Group = Group()
    @State private var groupList: [Group] = []
    @State private var linkSelection : Int? = nil
    @State private var showAlert = false
    @State private var objectList:[User] = []
    
    var body: some View {
        NavigationStack {
            VStack{
                NavigationLink(destination: Home(), tag: 1, selection: self.$linkSelection){}
//                NavigationLink(destination: Groups(), tag: 2, selection: self.$linkSelection){}
//                NavigationLink(destination: MyGroups(), tag: 3, selection: self.$linkSelection){}
//                NavigationLink(destination: JoinedGroups(), tag: 4, selection: self.$linkSelection){}
                Spacer(minLength: 100)
                Text("Create Group").foregroundColor(.white).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.title)
                Form{
                    Section{
                        TextField("Title", text: $groupTitle)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                        TextField("Description", text: $groupDescription)
                            .keyboardType(.default)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                    }
                    Button {
                        loadObjectListFromUserDefaults()
                        objectList = allUsers.allUsers
                        if let user = objectList.first(where: { $0.email == loggedInUser.email && $0.password == loggedInUser.password }) {
                            if(self.groupTitle.isEmpty || self.groupDescription.isEmpty) {
                                showAlert = true
                            } else {
                                groupObj.title = groupTitle
                                groupObj.description = groupDescription
                                groupObj.owner = user
                                
                                groupList.append(groupObj)
                                
                                if let loggedInUserData = allUsers.allUsers.first(where: { $0.email == loggedInUser.email }) {
                                    if let joinedGroupData = loggedInUserData.joinedGroup.first(where: { $0.title == groupTitle }) {
                                        print("User already present in the group");
                                    } else {
                                        loggedInUserData.joinedGroup.append(groupObj)
                                        allUsers.allUsers.removeAll{$0.email == loggedInUser.email}
                                        allUsers.allUsers.append(loggedInUserData)
                                        objectList = allUsers.allUsers
                                        print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
                                        print(loggedInUserData.joinedGroup)
                                        saveObjectListToUserDefaults()
                                        saveObjectListToDefaults()
                                        linkSelection = 1
                                    }
                                }
                                
                            }
                        }else {
                            linkSelection = 1
                        }
                        
                    } label: {
                        Text("Create Group")
                    }
                    .frame(maxWidth:.greatestFiniteMagnitude).foregroundColor(.red)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Missing Information"), message: Text("Please provide all required information."), dismissButton: .default(Text("OK")))
                    }
                }
                
                
                
            }
            .background(LinearGradient(colors: [Color("Gradient"),Color("Gradient1")], startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(maxHeight: .infinity)
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button {
                            linkSelection = 2
                        } label: {
                            Text("All Groups")
                        }
                        Button {
                            linkSelection = 3
                        } label: {
                            Text("My Groups")
                        }
                        Button {
                            linkSelection = 4
                        } label: {
                            Text("Joined Groups")
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .foregroundColor(Color(.white))
                    }
                }
            }

        }
        
    }
    func loadObjectListFromUserDefaults() {
        if let savedObjectListData = UserDefaults.standard.data(forKey: "groupList") {
            do {
                let decoder = JSONDecoder()
                groupList = try decoder.decode([Group].self, from: savedObjectListData)
                
                print(groupList)
            } catch {
                print("Error decoding object list: \(error.localizedDescription)")
            }
        } else {
            print("UserDefaults key 'groupList' is empty.")
        }
    }
    func saveObjectListToUserDefaults() {
        do {
            let encoder = JSONEncoder()
            let encoded = try encoder.encode(groupList)
            print("success")
            UserDefaults.standard.set(encoded, forKey: "groupList")
        } catch {
            print("Error encoding object list: \(error.localizedDescription)")
        }
    }
    
    func saveObjectListToDefaults() {
            do {
                let encoder = JSONEncoder()
                let encoded = try encoder.encode(objectList)
                print("success")
                UserDefaults.standard.set(encoded, forKey: "objectListKey")
                
                linkSelection = 1
            } catch {
                print("Error encoding object list: \(error.localizedDescription)")
            }
        }
}
struct CreateGroup_Previews: PreviewProvider {
    static var previews: some View {
        CreateGroup()
    }
}
