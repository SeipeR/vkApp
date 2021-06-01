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
    
    func fetchFriends() {
        let dataType = "friends.get"
        let parameters: Parameters = [
            "user_id": Session.instance.userId,
            "order": "name",
            "fields": "nickname",
            "v": version,
            "access_token": Session.instance.token
        ]
        
        fetchData(dataType, parameters)
    }
    
    func fetchFriendPhotos(ownerID id: Int) {
        let dataType = "photos.get"
        let parameters: Parameters = [
            "owner_id": String(id),
            "album_id": "profile",
            "v": version,
            "access_token": Session.instance.token
        ]
        
        fetchData(dataType, parameters)
    }
}
