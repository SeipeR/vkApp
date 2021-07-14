import SwiftyJSON

struct VKNewsfeed {
    let date: Int
    let text: String
    let photoURL: String
    let likeCount: Int
    let userLikes: Int
}

extension VKNewsfeed {
    init(_ json: JSON) {
        let date = json["date"].intValue
        let text = json["text"].stringValue
        let photoURL = json["attachments"][0]["photo"]["sizes"][6]["url"].stringValue
        let likeCount = json["likes"]["count"].intValue
        let userLikes = json["likes"]["user_likes"].intValue
        
        self.init(
            date: date,
            text: text,
            photoURL: photoURL,
            likeCount: likeCount,
            userLikes: userLikes
        )
    }
}
