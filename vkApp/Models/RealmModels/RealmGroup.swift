import RealmSwift

class RealmGroup: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var screenName: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var groupAvatar: String = ""
}
