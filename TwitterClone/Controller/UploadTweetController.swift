//
//  UploadTweetController.swift
//  TwitterClone
//
//  Created by Noah Miyabayashi on 2023/07/08.
//

import Foundation
import UIKit

class UploadTweetController: UIViewController {
    // MARK: - Properties
    //lazy var ensures that this element will be lazily loaded
    //Meaning that this button will only be loaded when called, which we load in configureUI()
    //Without this lazy decoration, the handler will not work due to the way code configuration works
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .twitterBlue
        button.setTitle("Tweet", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.layer.cornerRadius = 32 / 2
        button.addTarget(self, action: #selector(handleTweet), for: .touchUpInside)
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    // MARK: - Selectors
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleTweet() {
        print("DEBUG: Upload Tweet here")
    }
    // MARK: - API
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
}
