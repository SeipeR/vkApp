import UIKit

class NewsUserInfo: UITableViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configure(userImage: String, name: String, date: Date) {
        avatarImage.kf.setImage(with: URL(string: userImage))
        nameLabel.text = name
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM y HH:mm:ss"
        dateLabel.text = dateFormatter.string(from: date)
    }
}
