import RealmSwift
import SwiftyJSON

class RealmPhoto: Object {
    @objc dynamic var albumID: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerID: Int = 0
    @objc dynamic var bigPhotoURL: String = ""
   
    var sizes = List<RealmPhotoSize>()
    
    
    override class func primaryKey() -> String? {
        "id"
    }
}

extension RealmPhoto {
    convenience init(_ json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.albumID = json["album_id"].intValue
        self.ownerID = json["owner_id"].intValue
        
        let sizesArray = json["sizes"].arrayValue
        
        let photoSize = RealmPhotoSize()
        for size in sizesArray {
            photoSize.height = size["height"].intValue
            photoSize.width = size["width"].intValue
            photoSize.type = size["type"].stringValue
            photoSize.url = size["url"].stringValue
            self.bigPhotoURL = size["url"].stringValue
            sizes.append(photoSize)
        }
    }
}
