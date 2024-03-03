//
//  Signup.swift
//  Group2_Blogger
//
//  Created by Harsh Goyal on 14/02/24.
//

import SwiftUI

struct Signup: View {
    @State private var name:String = ""
    @State private var phNo: String = ""
    @State private var emailId: String = ""
    @State private var password : String = ""
    @State private var showAlert = false
    @State private var objectList: [User] = []
    @State private var linkSelection : Int? = nil
    @State private var testGroup : Group = Group()
    
    @EnvironmentObject var fireDBHelper: FirebaseDBHelper
    @EnvironmentObject var fireAuthHelper: FirebaseeAuthHelper
    
    private var userObject : User = User()
    var body: some View {
        VStack{
            NavigationLink(destination: Home(), tag: 1, selection: self.$linkSelection){}
            NavigationLink(destination: Signup(), tag: 2, selection: self.$linkSelection){}
            Spacer(minLength: 100)
            Text("Create Account").foregroundColor(.white).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.title)
            Form{
                
                Section{
                    TextField("Name", text: $name)
                                    .autocorrectionDisabled(true)
                                    .textInputAutocapitalization(.never)
                                    .keyboardType(.default)
                                    .padding()
                                    .cornerRadius(20.0)
                              TextField("Phone Number", text: $phNo)
                                    .autocorrectionDisabled(true)
                                    .textInputAutocapitalization(.never)
                                    .keyboardType(.phonePad)
                                    .padding()
                                    .cornerRadius(20.0)
                              TextField("Email id", text: $emailId)
                                    .autocorrectionDisabled(true)
                                    .textInputAutocapitalization(.never)
                                    .keyboardType(.emailAddress)
                                    .padding()
                                    .cornerRadius(20.0)
                              SecureField("Password", text: $password)
                                    .autocorrectionDisabled(true)
                                    .textInputAutocapitalization(.never)
                                    .keyboardType(.default)
                                    .padding()
                                    .cornerRadius(20.0)
                    
                }
                Button{if !name.isEmpty && !emailId.isEmpty && !phNo.isEmpty && !password.isEmpty {
                    
                        self.loadObjectListFromUserDefaults()
                        self.userObject.name = name
                        self.userObject.email = emailId
                        self.userObject.phoneNumber = phNo
                        self.userObject.password = password
                    
                    self.testGroup.title = "AI"
                    self.userObject.joinedGroup.append(testGroup)
                    print("00000000000000000000000000000000000000000000000")
                    print(userObject.joinedGroup)
                        objectList.append(userObject)
                        
    //                    Storing user object to preferences
                        self.saveObjectListToUserDefaults()
                    
                    self.fireAuthHelper.signUp(email: self.emailId, password: self.password)
                    
                } else {
                    // Perform action when all fields are provided
                    showAlert = true
                }
                    
                }label:{
                    Text("Create user ")
                }.frame(maxWidth: .infinity)
            }.alert(isPresented: $showAlert) {
                Alert(title: Text("Missing Information"), message: Text("Please provide all required information."), dismissButton: .default(Text("OK")))
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
                    
                    print(objectList)
                } catch {
                    print("Error decoding object list: \(error.localizedDescription)")
                }
            } else {
                print("UserDefaults key 'objectListKey' is empty.")
            }
        }
    func saveObjectListToUserDefaults() {
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


struct Signup_Previews: PreviewProvider {
    static var previews: some View {
        Signup()
    }
}
