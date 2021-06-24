struct VKPhoto {
    let id: Int
    let albumID: Int
    let ownerID: Int
    let sizes: [VKPhotoSize]
}


extension VKPhoto: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case albumID = "album_id"
        case ownerID = "owner_id"
        case sizes = "sizes"
    }
}
