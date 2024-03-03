//
//  Login.swift
//  Group2_Blogger
//
//  Created by Harsh Goyal on 14/02/24.
//

import SwiftUI

struct Login: View {
    var userObject  = User()
    @State private var objectList: [User] = []
    @EnvironmentObject var loggedInUser : User
    @EnvironmentObject var allUsers : AllUsers
    	
    @EnvironmentObject var fireDBHelper: FirebaseDBHelper
    @EnvironmentObject var fireAuthHelper: FirebaseeAuthHelper
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var linkSelection : Int? = nil
    var body: some View {
        ZStack{
            VStack{
                NavigationLink(destination: Home(), tag: 1, selection: self.$linkSelection){}
                NavigationLink(destination: PostBlog(), tag: 3, selection: self.$linkSelection){}
                NavigationLink(destination: Signup().environmentObject(self.fireAuthHelper).environmentObject(seslf.fireDBHelper), tag: 2, selection: self.$linkSelection){}
                
                Spacer(minLength: 160)

                Text("Login").foregroundColor(.white).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.title)
                Form{
                    Section{
                        TextField("Email", text: $email)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                        SecureField("Password", text: $password)
                            .keyboardType(.default)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                    }
                    Button {
                        loadObjectListFromUserDefaults()
                        allUsers.allUsers = objectList
                        
                        self.userObject.email = email
                        self.userObject.password = password
                        
                        self.fireAuthHelper.signIn(email: self.email, password: self.password)
                        
                        if let user = objectList.first(where: { $0.email == email && $0.password == password }) {
                            print("Found user: \(user.email), Age: \(user.password)")
                            loggedInUser.name = user.name
                            loggedInUser.phoneNumber = user.phoneNumber
                            loggedInUser.favourites = user.favourites
                            loggedInUser.profileImg = user.profileImg
                            loggedInUser.joinedGroup = user.joinedGroup
                            loggedInUser.id = user.id
                            loggedInUser.email = user.email
                            loggedInUser.password = user.password
                            print("////////////")
                            print(loggedInUser.joinedGroup)
                            linkSelection = 1
                        } else {
//                            linkSelection = 1
                        }
    //                        print("Found user: \(user.email), Age: \(user.password)")
                        if let encodedData = try? JSONEncoder().encode(userObject) {
                            UserDefaults.standard.set(encodedData, forKey: "userData")
                        }
                    }label:{
                        Text("Login")
                    }
                    .frame(maxWidth: .infinity)
                    
                    Button {
                       linkSelection = 2
                    }label:{
                        Text("Signup")
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                
//                .frame(height: 350)
            }
        }.background(LinearGradient(colors: [Color("Gradient"),Color("Gradient1")], startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(maxHeight: .infinity)
        
            .scrollContentBackground(.hidden)
     
    }
    func loadObjectListFromUserDefaults() {
            if let savedObjectListData = UserDefaults.standard.data(forKey: "objectListKey") {
                do {
                    let decoder = JSONDecoder()
                    objectList = try decoder.decode([User].self, from: savedObjectListData)
                } catch {
                    print("Error decoding object list: \(error.localizedDescription)")
                }
            } else {
                print("UserDefaults key 'objectListKey' is empty.")
                // Handle the case when the key is empty, e.g., provide a default value or perform another action
            }
        }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
