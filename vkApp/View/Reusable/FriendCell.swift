//
//  FriendCell.swift
//  vkApp
//
//  Created by Дамир Доронкин on 12.04.2021.
//

import UIKit
import Kingfisher

class FriendCell: UITableViewCell {
    
    @IBOutlet weak var friendAvatarImage: UIImageView!
    @IBOutlet weak var friendNameLabel: UILabel!
    
    func configure(imageURL: String, name: String) {
        friendAvatarImage.kf.setImage(with: URL(string: imageURL))
        friendNameLabel.text = name
    }
}
