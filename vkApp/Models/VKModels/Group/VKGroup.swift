struct VKGroup {
    let id: Int
    let name: String
    let screenName: String
    let type: String
    let groupAvatar: String
}

extension VKGroup: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case screenName = "screen_name"
        case type = "type"
        case groupAvatar = "photo_200"
    }
}
