//
//  FeedController.swift
//  TwitterClone
//
//  Created by Noah Miyabayashi on 2023/05/25.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "TweetCell"
class FeedController: UICollectionViewController {
    // MARK: - Properties
    private var tweets = [Tweet]() {
        didSet {collectionView.reloadData()}
    }
    var user: User? {
        didSet {
            print("DEBUG: Did set user in feed controller")// didSet block gets excecuted once user has been set in the fetchUser function
            configureLeftBarButton()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchTweets()
    }
    
    // MARK: - API
    
    func fetchTweets() {
        TweetService.shared.fetchTweets { tweets in
            print("DEBUG: Tweets are \(tweets.count)")
            self.tweets = tweets
        }
    }
    // MARK: - Helpers
    
    func configureUI() {
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        view.backgroundColor = .white
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 44, height: 44)
        navigationItem.titleView = imageView
    }
    
    func configureLeftBarButton() {
        guard let user = user else {return} //Guarantees that user exists, otherwise, function will stop here and return
        let profileImageView = UIImageView()
        profileImageView.backgroundColor = .twitterBlue
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32/2
        profileImageView.layer.masksToBounds = true
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
}
// MARK: -UICollectionViewDelegate/DataSource
extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        cell.delegate = self
        cell.tweet = tweets[indexPath.row]
        return cell
    }
}
// MARK: -UICollectionViewFlowLayout
extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}

// MARK: -TweetCellDelegate
extension FeedController: TweetCellDelegate {
    func handleProfileImageTapped(_ cell: TweetCell) {
        let controller = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(controller, animated: true)
    }
}
