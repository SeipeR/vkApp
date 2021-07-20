import UIKit

class NewsPhotoCell: UITableViewCell {
    @IBOutlet weak var newsImage: UIImageView!
    
    func configure(newsImage: String) {
        self.newsImage.kf.setImage(with: URL(string: newsImage))
    }
}
