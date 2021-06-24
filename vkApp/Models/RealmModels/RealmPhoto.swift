import RealmSwift

class RealmPhoto: Object {
    @objc dynamic var albumID: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerID: Int = 0
//    @objc dynamic var sizes: [PhotoSize] = []
}
