import UIKit

class NewsTextCell: UITableViewCell {
    @IBOutlet weak var newsLabel: UILabel!
    
    func configure(news: String) {
        newsLabel.text = news
    }
}
//
//extension UILabel {
//    
//}
