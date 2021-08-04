//
//  FriendCell.swift
//  vkApp
//
//  Created by Дамир Доронкин on 12.04.2021.
//

import UIKit

class FriendCell: UITableViewCell {
    
    @IBOutlet weak var friendAvatarImage: UIImageView!
    @IBOutlet weak var friendNameLabel: UILabel!
    
    func configure(imageURL: String,
                   name: String,
                   photoService: PhotoService) {
        
        self.friendAvatarImage.image = nil
        photoService.getImage(urlString: imageURL) { [weak self] image in
            DispatchQueue.main.async {
                self?.friendAvatarImage.image = image
            }
        }
        friendNameLabel.text = name
    }
}
