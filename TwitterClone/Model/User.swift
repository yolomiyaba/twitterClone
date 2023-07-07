//
//  User.swift
//  TwitterClone
//
//  Created by Noah Miyabayashi on 2023/07/07.
//

import Foundation

struct User {
    let fullName: String
    let email: String
    let userName: String
    let profileImageUrl: String
    let uid: String
    
    //By creating a model and initializing, we avoid having to parse data from dictionary every time we want to access data from snapshot
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        self.fullName = dictionary["fullName"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.userName = dictionary["userName"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}
