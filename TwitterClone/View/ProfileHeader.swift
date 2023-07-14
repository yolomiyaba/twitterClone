//
//  ProfileHeader.swift
//  TwitterClone
//
//  Created by Noah Miyabayashi on 2023/07/14.
//

import Foundation
import UIKit

class ProfileHeader: UICollectionReusableView {
    //MARK: - Properties
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Selectors
}
