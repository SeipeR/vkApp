struct Group {
    let id: Int
    let name: String
    let screenName: String
    let type: String
    let groupAvatar: String
}

extension Group: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case screenName = "screen_name"
        case type = "type"
        case groupAvatar = "photo_200"
    }
}
