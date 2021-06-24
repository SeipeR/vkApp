struct VKPhotoSize {
    let url: String
    let width: Int
    let height: Int
    let type: String
}

extension VKPhotoSize: Codable {
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case width = "width"
        case height = "height"
        case type = "type"
    }
}
