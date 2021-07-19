import SwiftyJSON

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

extension VKGroup {
    init(_ json: JSON) {
        let id = json["id"].intValue
        let name = json["first_name"].stringValue
        let screenName = json["last_name"].stringValue
        let type = json["type"].stringValue
        let groupAvatar = json["photo_200"].stringValue
        
        self.init(
            id: id,
            name: name,
            screenName: screenName,
            type: type,
            groupAvatar: groupAvatar
        )
    }
}

//extension VKGroup: Persistable {
//    public init(managedObject: RealmGroup) {
//        id = managedObject.id
//        name = managedObject.name
//        screenName = managedObject.screenName
//        type = managedObject.type
//        groupAvatar = managedObject.groupAvatar
//    }
//    public func managedObject() -> RealmGroup {
//        let group = RealmGroup()
//        group.id = id
//        group.name = name
//        group.screenName = screenName
//        group.type = type
//        group.groupAvatar = groupAvatar
//        return group
//    }
//}
