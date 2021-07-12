import UIKit
import Alamofire

final class NetworkService {
    static let instance = NetworkService()
    
    private init() {}
    
    let host = "https://api.vk.com/method/"
    let version = "5.131"
    
    func fetchData <T:Codable> (_ dataType: String, _ parameters: Parameters, _ VKStruct: T.Type) {
        AF.request(host + dataType, method: .get, parameters: parameters)
            .responseDecodable(of: VKResponse<T>.self) { response in
                switch response.result {
                case .success(let vkResponse):
                    // Установка точки останова и ввод команды po vkResponse не даёт проверить содержимое. Хотя запрос и обработка данных происходят корректно. Объявление дополнительной переменной решает проблему.
                    let vkResponseTemp: VKResponse<T>
                    vkResponseTemp = vkResponse
                    print(vkResponseTemp)
                case .failure(let afError):
                    print(afError)
                }
            }
    }
    
    func fetchFriends(userID id: Int) {
        let dataType = "friends.get"
        let parameters: Parameters = [
            "user_id": id,
            "order": "name",
            "fields": "photo_200",
            "v": version,
            "access_token": Session.instance.token
        ]
        
        fetchData(dataType, parameters, VKFriends.self)
    }
    
    func fetchFriendPhotos(userID id: Int) {
        let dataType = "photos.get"
        let parameters: Parameters = [
            "owner_id": id,
            "album_id": "profile",
            "v": version,
            "access_token": Session.instance.token
        ]
        
        fetchData(dataType, parameters, VKPhotos.self)
    }
    
    func fetchFriendGroups(userID id: Int) {
        let dataType = "groups.get"
        let parameters: Parameters = [
            "user_id": id,
            "extended": "1",
            "v": version,
            "access_token": Session.instance.token
        ]
        
        fetchData(dataType, parameters, VKGroups.self)
    }
    
    func fetchGroupsSearch(searchString: String) {
        let dataType = "groups.search"
        let parameters: Parameters = [
            "q": searchString,
            "v": version,
            "access_token": Session.instance.token
        ]
        
        fetchData(dataType, parameters, VKGroups.self)
    }
}
