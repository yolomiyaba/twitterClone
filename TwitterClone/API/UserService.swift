//
//  UserService.swift
//  TwitterClone
//
//  Created by Noah Miyabayashi on 2023/07/06.
//

import Foundation
import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else {return}
                    print("DEBUG: Dictionary is \(dictionary)")
            
           // guard let userName = dictionary["userName"] as? String else {return}
            let user = User(uid: uid, dictionary: dictionary)
        }
    }
}
