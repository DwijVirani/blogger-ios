//
//  FirebaseDBHelper.swift
//  Group2_Blogger
//
//  Created by Dwij on 2024-03-03.
//

import Foundation
import FirebaseFirestore

class FirebaseDBHelper : ObservableObject{
    private static var shared : FirebaseDBHelper?
    private let db : Firestore
    
    private let COLLECTION_USER: String = "User"
    private let FIELD_EMAIL: String = "email"
    private let FIELD_PHONE: String = "phoneNumber"
    private let FIELD_NAME: String = "name"
    private let FIELD_PASSWORD: String = "password"
    
    init(db : Firestore){
        self.db = db
    }
    
    static func getInstance() -> FirebaseDBHelper{
        if (shared == nil){
            shared = FirebaseDBHelper(db: Firestore.firestore())
        }
        
        return shared!
    }
    
    func addUserToDB(newUser: User) {
        do{
            try self.db
                .collection(COLLECTION_USER)
                .addDocument(from: newUser)
        } catch let err as NSError {
            print(#function, "Unable to add document to firebase: \(err)")
        }
    }
}
