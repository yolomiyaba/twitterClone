//
//  TweetService.swift
//  TwitterClone
//
//  Created by Noah Miyabayashi on 2023/07/08.
//

import Foundation
import Firebase

struct TweetService {
    static let shared = TweetService()
    
    func uploadTweet(caption: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let values = ["uid": uid, "timestamp": Int(NSDate().timeIntervalSince1970), "likes": 0, "retweets": 0, "caption": caption] as [String : Any]
        //creates child with automatic uuid (for each tweet)
        REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
}


