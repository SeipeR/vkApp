struct VKPhoto {
    let id: Int
    let albumID: Int
    let ownerID: Int
    let photoURL: String
}


extension VKPhoto: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case albumID = "album_id"
        case ownerID = "owner_id"
        case photoURL = "photoURL"
    }
}

//extension VKPhoto: Persistable {
//    public init(managedObject: RealmPhoto) {
//        id = managedObject.id
//        albumID = managedObject.albumID
//        ownerID = managedObject.ownerID
//        sizes = managedObject.photos
//    }
//    public func managedObject() -> RealmPhoto {
//        let photo = RealmPhoto()
//        photo.id = id
//        photo.albumID = albumID
//        photo.ownerID = ownerID
//        photo.photos = sizes
//
//        return photo
//    }
//}
