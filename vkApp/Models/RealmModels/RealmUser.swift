import RealmSwift
import SwiftyJSON

class RealmUser: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var userAvatarURL: String = ""
    var fullName: String { "\(firstName) \(lastName)" }
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    override class func indexedProperties() -> [String] {
        ["firstName", "lastName"]
    }
}

extension RealmUser {
    convenience init(_ json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.userAvatarURL = json["photo_200"].stringValue
    }
}
