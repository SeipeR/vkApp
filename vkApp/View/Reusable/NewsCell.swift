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
    
    func configure(userImage: String, name: String, date: Date, news: String, newsImage: String, isLiked: Int, likeCount: Int) {
        avatarImage.kf.setImage(with: URL(string: userImage))
        nameLabel.text = name
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM y HH:mm:ss"
        dateLabel.text = dateFormatter.string(from: date)
        newsLabel.text = news
        self.newsImage.kf.setImage(with: URL(string: newsImage))
        likeCountLabel.text = "\(likeCount)"
        if isLiked != 0 {
            likeButtonOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
}
