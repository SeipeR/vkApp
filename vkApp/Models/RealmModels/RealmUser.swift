import RealmSwift

class RealmUser: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var userAvatarURL: String = ""
    var fullName: String { "\(firstName) \(lastName)" }
    
//    var userPhotos = List<RealmUser>()
//    let someUserLinked = LinkingObjects(fromType: RealmUser.self, property: "id")
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    override class func indexedProperties() -> [String] {
        ["firstName", "lastName"]
    }
}
