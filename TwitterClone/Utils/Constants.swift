//
//  Constants.swift
//  TwitterClone
//
//  Created by Noah Miyabayashi on 2023/07/06.
//

import Foundation
import Firebase

//Creating global constants is OK. However, you should never create global variables.
//Costants should be notated as CAPITAL_UNDERSCORE_CAPITAL
let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_TWEETS = DB_REF.child("tweets")
//let ref = Database.database().reference().child("users").child(uid)
//Database.database().reference() ... Looks at info.plist to find url for database for this app
//.child("users") ... Inside database url, creats a structure called "users"
//.child(uid) ... Inside structure "users," creates a structure called the uid of authenticaied user.

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

