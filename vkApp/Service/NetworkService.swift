import UIKit
import Alamofire
import SwiftyJSON

final class NetworkService {
    static let instance = NetworkService()
    
    private init() {}
    
    let host = "https://api.vk.com/method/"
    let version = "5.131"
    
    func fetchFriends(userID id: Int, completion: @escaping ([RealmUser]?) -> Void){
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
                    let json = JSON(data)
                    let usersJSONs = json["response"]["items"].arrayValue
                    let vkUsers = usersJSONs.map { RealmUser($0) }
                    DispatchQueue.main.async {
                        completion(vkUsers)
                    }
                case .failure(let error):
                    print(error)
                    completion(nil)
                }
            }
    }
    
    func fetchFriendPhotos(userID id: Int, completion: @escaping ([RealmPhoto]?) -> Void) {
        let dataType = "photos.getAll"
        let parameters: Parameters = [
            "owner_id": id,
            "album_id": "profile",
            "count": 30,
            "extended": "1",
            "photo_sizes": "1",
            "v": version,
            "access_token": Session.instance.token
        ]
        
        AF.request(host + dataType, method: .get, parameters: parameters)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let photosJSONs = json["response"]["items"].arrayValue
                    let vkPhotos = photosJSONs.map { RealmPhoto($0) }
                    DispatchQueue.main.async {
                        completion(vkPhotos)
                    }
                case .failure(let error):
                    print(error)
                    completion(nil)
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
