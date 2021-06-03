struct VKPhoto {
    let albumID: Int
    let id: Int
    let ownerID: Int
    let sizes: [PhotoSize]
}


extension VKPhoto: Codable {
    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case id = "id"
        case ownerID = "owner_id"
        case sizes = "sizes"
    }
}
