//
//  MainTabController.swift
//  TwitterClone
//
//  Created by Noah Miyabayashi on 2023/05/25.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    // MARK: - Properties
    var user: User? {
        didSet { // didSet enables us to do something once a property has been set, which ensures that the property has been set
            print("DEBUG: Did set user in main tab") // didSet block gets excecuted once user has been set in the fetchUser function
            
            //How to correctly pass values through a tab bar controller
            guard let nav = viewControllers?[0] as? UINavigationController else {return}
            guard let feed = nav.viewControllers.first as? FeedController else {return}
            
            feed.user = user
        }
    }
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
        
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        //logUserOut()
        super.viewDidLoad()
        view.backgroundColor = .twitterBlue
        fetchUser()
        authenticateUserAndConfigureUI()
        //fetchUser()
    }
    // MARK: - API
    
    func fetchUser() {
        UserService.shared.fetchUser { user in
            self.user = user
        } //By configuring user in tab controller, we can reference this user info from controllers within tab bar
    }
    func authenticateUserAndConfigureUI() {
        //print(Auth.auth().currentUser)
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
            print("DEBUG: User is not loged in")
        } else {
            print("DEBUG: User is loged in")
            configureViewControllers()
            configureUI()
        }
    }
    
    func logUserOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    // MARK: - Selectors
    
    @objc func actionButtonTapped() {
        guard let user = user else {return}
        let controller = UploadTweetController(user: user) //Because we created an initializer in UploadTweetController, we must specify the user parameter.
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    
    // MARK: - Helpers
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56 / 2
    }
    
    // Programattically configure ViewControllers to TabBarController
    func configureViewControllers() {
        let feed = FeedController()
        let nav1 = templateNavigationController(image: UIImage(named: "home_unselected"), rootNavigationController: feed)
        let explore = ExploreController()
        let nav2 = templateNavigationController(image: UIImage(named: "search_unselected"), rootNavigationController: explore)
        let notifications = NotificationsController()
        let nav3 = templateNavigationController(image: UIImage(named: "like_unselected"), rootNavigationController: notifications)
        let conversations = ConversationsController()
        let nav4 = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootNavigationController: conversations)
        viewControllers = [nav1, nav2, nav3, nav4]
    }
    
    // Create function to assign rootViewControllers to NavigationController
    func templateNavigationController(image: UIImage?, rootNavigationController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootNavigationController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        nav.navigationBar.backgroundColor = .white
        return nav
    }

}
