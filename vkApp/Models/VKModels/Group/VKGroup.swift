struct VKGroup: Equatable {
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

extension VKGroup: Persistable {
    public init(managedObject: RealmGroup) {
        id = managedObject.id
        name = managedObject.name
        screenName = managedObject.screenName
        type = managedObject.type
        groupAvatar = managedObject.groupAvatar
    }
    public func managedObject() -> RealmGroup {
        let group = RealmGroup()
        group.id = id
        group.name = name
        group.screenName = screenName
        group.type = type
        group.groupAvatar = groupAvatar
        return group
    }
}
