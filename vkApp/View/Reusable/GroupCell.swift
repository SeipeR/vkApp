//
//  GroupCell.swift
//  vkApp
//
//  Created by Дамир Доронкин on 12.04.2021.
//

import UIKit

class GroupCell: UITableViewCell {
    
    @IBOutlet weak var groupAvatarImage: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    
    func configure(image: UIImage?, name: String) {
        groupAvatarImage.image = image
        groupNameLabel.text = name
    }
}
