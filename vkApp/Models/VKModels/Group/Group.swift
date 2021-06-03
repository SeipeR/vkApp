struct Group {
    let id: Int
    let name: String
    let screenName: String
    let groupAvatar: String
}

extension Group: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case screenName = "screen_name"
        case groupAvatar = "photo_200"
    }
}
