//
//  FirebaseeAuthHelper.swift
//  Group2_Blogger
//
//  Created by Dwij on 2024-03-03.
//

import Foundation
import FirebaseAuth

class FirebaseeAuthHelper: ObservableObject{
    
    @Published var user : FirebaseAuth.User?{
        didSet{
            objectWillChange.send()
        }
    }
    
    
    func listenToAuthState(){
        Auth.auth().addStateDidChangeListener{ [weak self] _, user in
            guard let self = self else{
                //no change in the auth state
                return
            }
            
            //user's auth state has changed
            self.user = user
        }
    }
    
    func signUp(email : String, password : String){
        
        Auth.auth().createUser(withEmail: email, password: password){ [self] authResult, error in
            
            guard let result = authResult else{
                print(#function, "Error while creating account : \(String(describing: error) )")
                return
            }
            
            print(#function, "AuthResult : \(result)")
            
            switch authResult{
            case .none:
                print(#function, "Unable to create the account")
            case .some(_):
                print(#function, "Successfully created user account")
                self.user = authResult?.user
                
                UserDefaults.standard.set(self.user?.email, forKey: "KEY_EMAIL")
                UserDefaults.standard.set(password, forKey: "KEY_PASSWORD")
            }
            
        }
    }
    
    func signIn(email : String, password : String){
        
        Auth.auth().signIn(withEmail: email, password: password){ [self] authResult, error in
            
            guard let result = authResult else{
                print(#function, "Error while logging in : \(String(describing: error) )")
                return
            }
            
            print(#function, "AuthResult : \(result)")
            
            switch authResult{
            case .none:
                print(#function, "Unable to sign in")
            case .some(_):
                print(#function, "Login Successful")
                self.user = authResult?.user
                
                print(#function, "Logged in user : \(self.user?.displayName ?? "NA" )")
                
                UserDefaults.standard.set(self.user?.email, forKey: "KEY_EMAIL")
                UserDefaults.standard.set(password, forKey: "KEY_PASSWORD")
            }
            
        }
        
    }
    
    func signOut(){
        do{
            try Auth.auth().signOut()
        }catch let err as NSError{
            print(#function, "Unable to sign out the user : \(err)")
        }
    }
    
}
