import UIKit

class NewsLikes: UITableViewCell {
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
    
    func configure(isLiked: Int, likeCount: Int) {
        likeCountLabel.text = "\(likeCount)"
        if isLiked != 0 {
            likeButtonOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
}
