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
            UIView.transition(with: likeButtonOutlet, duration: 0.7, options: [.transitionCrossDissolve, .transitionFlipFromTop]) {
                self.likeButtonOutlet.setImage(UIImage(systemName: "heart"), for: .normal)
            }
            
            UIView.transition(with: likeCountLabel, duration: 0.7, options: [.transitionCrossDissolve, .transitionFlipFromTop]) {
                self.likeCountLabel.text = "\(UInt32(self.likeCountLabel.text!)! - 1)"
            }
        } else {
            UIView.transition(with: likeButtonOutlet, duration: 0.7, options: [.transitionCrossDissolve, .curveEaseInOut,]) {
                self.likeButtonOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
            
            UIView.transition(with: likeCountLabel, duration: 0.7, options: [.transitionCrossDissolve, .curveEaseInOut,]) {
                self.likeCountLabel.text = "\(UInt32(self.likeCountLabel.text!)! + 1)"
            }
        }
    }
    
    func configure(imageURL: String) {
        photo.kf.setImage(with: URL(string: imageURL))
    }
    
//    func configure(image: UIImage?, isLiked: Bool, likeCount: UInt32) {
//        photo.image = image
//        likeCountLabel.text = "\(likeCount)"
//        if isLiked {
//            likeButtonOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//        }
//    }
}
