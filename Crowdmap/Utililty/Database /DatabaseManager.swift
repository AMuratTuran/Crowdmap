//
//  DatabaseManager.swift
//  Crowdmap
//
//  Created by KS Murat Turan on 10.04.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase


class DatabaseManager {
    
    var ref: DocumentReference? = nil
    let db = Firestore.firestore()

    func createUserAndSave(_ name: String, _ lastName: String, _ email: String){
        
        User.user.name = name
        User.user.lastName = lastName
        User.user.email = email
        
        db.collection("users").document(email).setData([
            "first": name,
            "last": lastName,
            "email": email
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(email)")
            }
        }
    }
}
