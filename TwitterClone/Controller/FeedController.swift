//
//  FeedController.swift
//  TwitterClone
//
//  Created by Noah Miyabayashi on 2023/05/25.
//

import UIKit

class FeedController: UIViewController {
    // MARK: - Properties
    var user: User? {
        didSet {
            print("DEBUG: Did set user in feed controller") // didSet block gets excecuted once user has been set in the fetchUser function
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        let profileImageView = UIImageView()
        profileImageView.backgroundColor = .twitterBlue
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32/2
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
}

