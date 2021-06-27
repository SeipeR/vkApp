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

extension VKUser: Persistable {
    public init(managedObject: RealmUser) {
        id = managedObject.id
        firstName = managedObject.firstName
        lastName = managedObject.lastName
        userAvatarURL = managedObject.userAvatarURL
    }
    public func managedObject() -> RealmUser {
        let user = RealmUser()
        user.id = id
        user.firstName = firstName
        user.lastName = lastName
        user.userAvatarURL = userAvatarURL
        return user
    }
}
