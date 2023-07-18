//
//  ConversationsController.swift
//  TwitterClone
//
//  Created by Noah Miyabayashi on 2023/05/25.
//

import UIKit

class ConversationsController: UIViewController {
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Conversations"
    }
}
