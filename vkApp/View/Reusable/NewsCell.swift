//
//  NewsCell.swift
//  vkApp
//
//  Created by Дамир Доронкин on 22.04.2021.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var likeButtonOutlet: UIButton!
    @IBAction func likeButtonAction(_ sender: UIButton) {
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
    @IBOutlet weak var likeCountLabel: UILabel!
    
//    func configure(userImage: UIImage?, name: String, date: String, news: String, newsImage: UIImage?, isLiked: Bool, likeCount: UInt32) {
//        avatarImage.image = userImage
//        nameLabel.text = name
//        dateLabel.text = date
//        newsLabel.text = news
//        self.newsImage.image = newsImage
//        likeCountLabel.text = "\(likeCount)"
//        likeButtonOutlet.setImage(UIImage(systemName: "heart"), for: .normal)
//        if isLiked {
//            likeButtonOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//        }
//    }
    
    func configure(date: Int, text: String, imageURL: String, likeCount: Int, isLiked: Int) {
        avatarImage.kf.setImage(with: URL(string: imageURL))
        self.newsImage.kf.setImage(with: URL(string: imageURL))
        dateLabel.text = String(date)
        newsLabel.text = text
        
        likeCountLabel.text = "\(likeCount)"
        if isLiked != 0 {
            likeButtonOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
}
