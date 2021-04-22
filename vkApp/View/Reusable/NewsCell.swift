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
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            likeCountLabel.text = "\(UInt32(likeCountLabel.text!)! - 1)"
        } else {
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeCountLabel.text = "\(UInt32(likeCountLabel.text!)! + 1)"
        }
    }
    @IBOutlet weak var likeCountLabel: UILabel!
    
    func configure(userImage: UIImage?, name: String, date: String, news: String, newsImage: UIImage?, isLiked: Bool, likeCount: UInt32) {
        avatarImage.image = userImage
        nameLabel.text = name
        dateLabel.text = date
        newsLabel.text = news
        self.newsImage.image = newsImage
        likeCountLabel.text = "\(likeCount)"
        if isLiked {
            likeButtonOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
}
