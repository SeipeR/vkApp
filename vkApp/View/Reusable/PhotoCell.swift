//
//  PhotoCell.swift
//  vkApp
//
//  Created by Дамир Доронкин on 12.04.2021.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var likeButtonOutlet: UIButton!
    @IBAction func action(_ sender: UIButton) {
        if sender.image(for: .normal) == UIImage(systemName: "heart.fill") {
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            likeCountLabel.text = "\(UInt32(likeCountLabel.text!)! - 1)"
        } else {
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeCountLabel.text = "\(UInt32(likeCountLabel.text!)! + 1)"
        }
    }
    
    
    func configure(image: UIImage?, isLiked: Bool, likeCount: UInt32) {
        photo.image = image
        likeCountLabel.text = "\(likeCount)"
        if isLiked {
            likeButtonOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
}
