//
//  DataService.swift
//  Gourmai
//
//  Created by Zack Esm on 6/24/17.
//  Copyright © 2017 Zack Esm. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

let URL_BASE = Database.database().reference()
let URL_STORAGE = Storage.storage().reference()

class DataService {
    static let ds = DataService()
    
    private var _REF_BASE = URL_BASE
    private var _REF_USERS = URL_BASE.child("users")
    private var _REF_STORAGE = URL_STORAGE
    private var _REF_POSTS = URL_BASE.child("posts")
    private var _REF_FACEBOOK_USERS = URL_BASE.child("userByFacebookID")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_STORAGE: StorageReference {
        return _REF_STORAGE
    }
    
    var REF_POSTS: DatabaseReference {
        return _REF_POSTS
    }
    
    var REF_CURRENT_USER: DatabaseReference {
        let uid = UserDefaults.standard.value(forKey: KEY_UID) as! String
        let user = REF_USERS.child(uid)
        print(uid)
        return user
    }
    
    var REF_FACEBOOK_USERS: DatabaseReference {
        return _REF_FACEBOOK_USERS
    }
    
    func createFirebaseUser(uid: String, facebookID: String, user: Dictionary<String, String>) {
        REF_USERS.child(uid).child("account").updateChildValues(user)
        let facebookDict = ["firebaseID": uid]
        REF_FACEBOOK_USERS.child(facebookID).updateChildValues(facebookDict)
    }
    
}
