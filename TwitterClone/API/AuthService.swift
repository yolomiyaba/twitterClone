//
//  AuthService.swift
//  TwitterClone
//
//  Created by Noah Miyabayashi on 2023/07/06.
//

import Foundation
import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let userName: String
    let fullName: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService() // By creating a static instance of AuthSercice, every time we use AuthService.shared, this particular instance of AuthService will be used!
    
    func registerUser(credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void) {
        let email = credentials.email
        let password = credentials.password
        let userName = credentials.userName
        let fullName = credentials.fullName
        
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else {return}
        let filename = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            storageRef.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else {return}
                
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error {
                        print("DEBUG: Error is \(error.localizedDescription)")
                        return
                    }
                    guard let uid = result?.user.uid else {return}
                    
                    let values = ["email": email,
                                  "userName": userName,
                                  "fullName": fullName,
                                  "profileImageUrl": profileImageUrl]
                    
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                    // By creating this input variable, we can pass a completion block so that we can excecute certain things in the ViewController after the API Call has succeeded!
                    
                    print("DEBUG: Successfully regestered user")
                }
            }
        }
    }
}
