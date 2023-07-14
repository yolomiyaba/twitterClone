//
//  TweetViewModel.swift
//  TwitterClone
//
//  Created by Noah Miyabayashi on 2023/07/14.
//

import Foundation
import UIKit

// View Models take stress off of View Classes. View Controllers should be as simple as possible, as in only containing UI components. If there is any other complex computation, it you should create a View Model
struct TweetViewModel {
    let tweet: Tweet
    let user: User
    var profileImageUrl: URL? {
        return tweet.user.profileImageUrl
    }
    var timeStamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: tweet.timestamp, to: now) ?? "2m"
    }
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: user.fullName, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        title.append(NSAttributedString(string: " @\(user.userName)",attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        title.append(NSAttributedString(string: "・ \(timeStamp)",attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        return title
    }
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
}
