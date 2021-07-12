struct VKItems<T:Codable>: Codable {
    let count: Int
    let items: [T]
}

