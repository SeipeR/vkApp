import UIKit
import Alamofire

final class NetworkService {
    static let instance = NetworkService()
    
    private init() {}
    
    let host = "https://api.vk.com/method/"
    let version = "5.131"
    
//    func fetchData <T:Codable> (_ dataType: String, _ parameters: Parameters, _ VKStruct: T.Type) {
//        AF.request(host + dataType, method: .get, parameters: parameters)
//            .responseDecodable(of: VKResponse<T>.self) { response in
//                switch response.result {
//                case .success(let vkResponse):
//                    // Установка точки останова и ввод команды po vkResponse не даёт проверить содержимое. Хотя запрос и обработка данных происходят корректно. Объявление дополнительной переменной решает проблему.
//                    let vkResponseTemp: VKResponse<T>
//                    vkResponseTemp = vkResponse
//                    print(vkResponseTemp)
//                case .failure(let afError):
//                    print(afError)
//                }
//            }
//    }
    
    func fetchFriends(userID id: Int, completion: @escaping ([VKUser]?) -> Void){
        let dataType = "friends.get"
        let parameters: Parameters = [
            "user_id": id,
            "order": "name",
            "fields": "photo_200",
            "v": version,
            "access_token": Session.instance.token
        ]

        AF.request(host + dataType, method: .get, parameters: parameters)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let vkPhotos = try JSONDecoder().decode(VKResponse<VKItems<VKUser>>.self, from: data)
                        DispatchQueue.main.async {
                            completion(vkPhotos.response.items)
                        }
                    } catch {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func fetchFriendPhotos(userID id: Int, completion: @escaping ([VKPhoto]?) -> Void) {
        let dataType = "photos.getAll"
        let parameters: Parameters = [
            "owner_id": id,
            "album_id": "profile",
            "extended": "1",
            "photo_sizes": "1",
            "v": version,
            "access_token": Session.instance.token
        ]
        
        AF.request(host + dataType, method: .get, parameters: parameters)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let vkPhotos = try JSONDecoder().decode(VKResponse<VKItems<VKPhoto>>.self, from: data)
                        completion(vkPhotos.response.items)
                    } catch {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func fetchFriendGroups(userID id: Int, completion: @escaping ([VKGroup]?) -> Void) {
        let dataType = "groups.get"
        let parameters: Parameters = [
            "user_id": id,
            "extended": "1",
            "v": version,
            "access_token": Session.instance.token
        ]
        
        AF.request(host + dataType, method: .get, parameters: parameters)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let vkGroups = try JSONDecoder().decode(VKResponse<VKItems<VKGroup>>.self, from: data)
                        completion(vkGroups.response.items)
                    } catch {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func fetchGroupsSearch(searchString: String, completion: @escaping ([VKGroup]?) -> Void) {
        let dataType = "groups.search"
        let parameters: Parameters = [
            "q": searchString,
            "v": version,
            "access_token": Session.instance.token
        ]
        
        AF.request(host + dataType, method: .get, parameters: parameters)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let vkGroups = try JSONDecoder().decode(VKResponse<VKItems<VKGroup>>.self, from: data)
                        completion(vkGroups.response.items)
                    } catch {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}
