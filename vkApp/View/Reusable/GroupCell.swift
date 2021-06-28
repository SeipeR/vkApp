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
    
    func configure(imageURL: String, name: String) {
        groupAvatarImage.kf.setImage(with: URL(string: imageURL))
        groupNameLabel.text = name
    }
}
