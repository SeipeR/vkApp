struct VKUser {
    let id: Int
    let firstName: String
    let lastName: String
    let userAvatarURL: String
    var fullName: String {"\(firstName) \(lastName)"}
}


extension VKUser: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case userAvatarURL = "photo_200"
    }
}
