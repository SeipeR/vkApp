import UIKit
import Alamofire

final class NetworkService {
    static let instance = NetworkService()
    
    private init() {}
    
    let host = "https://api.vk.com/method/"
    let version = "5.131"
    
    func fetchData (_ dataType: String, _ parameters: Parameters) {
        AF.request(host + dataType, method: .get, parameters: parameters).responseJSON { response in
            print(response.value ?? "Error")
        }
    }
    
    func fetchFriends(userID id: Int) {
        let dataType = "friends.get"
        let parameters: Parameters = [
            "user_id": id,
            "order": "name",
            "fields": "nickname",
            "v": version,
            "access_token": Session.instance.token
        ]
        
        fetchData(dataType, parameters)
    }
    
    func fetchFriendPhotos(userID id: Int) {
        let dataType = "photos.get"
        let parameters: Parameters = [
            "owner_id": id,
            "album_id": "profile",
            "v": version,
            "access_token": Session.instance.token
        ]
        
        fetchData(dataType, parameters)
    }
    
    func fetchFriendGroups(userID id: Int) {
        let dataType = "groups.get"
        let parameters: Parameters = [
            "user_id": id,
            "extended": "1",
            "v": version,
            "access_token": Session.instance.token
        ]
        
        fetchData(dataType, parameters)
    }
    
    func fetchGroupsSearch(searchString: String) {
        let dataType = "groups.search"
        let parameters: Parameters = [
            "q": searchString,
            "type": "group",
            "v": version,
            "access_token": Session.instance.token
        ]
        
        fetchData(dataType, parameters)
    }
}
