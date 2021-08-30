import RealmSwift
import SwiftyJSON

class RealmPhotoSize: Object {
    @objc dynamic var url: String = ""
    @objc dynamic var width: Int = 0
    @objc dynamic var height: Int = 0
    @objc dynamic var type: String = ""
    
    let owners = LinkingObjects(fromType: RealmPhoto.self, property: "sizes")
    
    override class func primaryKey() -> String? {
        "url"
    }
}

extension RealmPhotoSize {
    convenience init(_ json: JSON) {
        self.init()
        self.url = json["url"].stringValue
        self.width = json["width"].intValue
        self.height = json["height"].intValue
        self.type = json["type"].stringValue
    }
}
