import SwiftyJSON

struct VKNewsfeed {
    let id: Int
    let date: Int
    let text: String
    let type: String
    let photoURL: String
    let photoWidth: Int
    let photoHeight: Int
    let likeCount: Int
    let userLikes: Int
    
    var photosAspectRatio: CGFloat { CGFloat(photoWidth) / CGFloat(photoHeight) }
}

extension VKNewsfeed {
    init(_ json: JSON) {
        let id = json["source_id"].intValue
        let date = json["date"].intValue
        let text = json["text"].stringValue
        let type = json["attachments"][0]["type"].stringValue
        let photoURL = json["attachments"][0]["photo"]["sizes"][6]["url"].stringValue
        let photoWidth = json["attachments"][0]["photo"]["sizes"][6]["width"].intValue
        let photoHeight = json["attachments"][0]["photo"]["sizes"][6]["height"].intValue
        let likeCount = json["likes"]["count"].intValue
        let userLikes = json["likes"]["user_likes"].intValue
        
        self.init(
            id: id,
            date: date,
            text: text,
            type: type,
            photoURL: photoURL,
            photoWidth: photoWidth,
            photoHeight: photoHeight,
            likeCount: likeCount,
            userLikes: userLikes
        )
    }
}
