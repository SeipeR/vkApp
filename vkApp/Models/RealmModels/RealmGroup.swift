import RealmSwift
import SwiftyJSON

class RealmGroup: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var screenName: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var groupAvatar: String = ""
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    override class func indexedProperties() -> [String] {
        ["screenName"]
    }
}

extension RealmGroup {
    convenience init(_ json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.screenName = json["screen_name"].stringValue
        self.type = json["type"].stringValue
        self.groupAvatar = json["photo_200"].stringValue
    }
}
