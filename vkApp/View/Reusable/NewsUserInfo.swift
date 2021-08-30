import UIKit

class NewsUserInfo: UITableViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configure(userImage: String, name: String, date: String) {
        avatarImage.kf.setImage(with: URL(string: userImage))
        nameLabel.text = name
        dateLabel.text = date
    }
}
