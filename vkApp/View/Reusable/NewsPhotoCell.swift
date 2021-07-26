import UIKit

//class ScaledHeightImageView: UIImageView {
//    override var intrinsicContentSize: CGSize {
//        if let myImage = self.image {
//            let myImageWidth = myImage.size.width
//            let myImageHeight = myImage.size.height
//            let myViewWidth = self.frame.size.width
//
//            let ratio = myViewWidth / myImageWidth
//            let scaledHeight = myImageHeight * ratio
//
//            return CGSize(width: myViewWidth, height: scaledHeight)
//        }
//
//        return CGSize(width: -1.0, height: -1.0)
//    }
//}

class NewsPhotoCell: UITableViewCell {
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsImageHeight: NSLayoutConstraint!
    
    func configure(newsImage: String, imageAspectRatio: CGFloat) {
        self.newsImage.kf.setImage(with: URL(string: newsImage))
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let imageHeight = (screenWidth - 30.0) / imageAspectRatio
        newsImageHeight.constant = imageHeight
    }
}
