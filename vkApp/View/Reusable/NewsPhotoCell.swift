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
    
    func configure(newsImage: String,
                   photoService: PhotoService) {
        
        self.newsImage.image = nil
        photoService.getImage(urlString: newsImage) { [weak self] image in
            DispatchQueue.main.async {
                self?.newsImage.image = image
            }
        }
    }
}
