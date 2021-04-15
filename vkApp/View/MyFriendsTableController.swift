//
//  TableViewController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 08.04.2021.
//

import UIKit

class MyFriendsTableController: UITableViewController {
    var friends = [
        UserModel(userName: "Ann Takamaki", userAvatar: UIImage(named: "Ann"), userPhotos: [(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32), (image: UIImage(named: "Ann"), isLiked: false, likeCount: 0),]),
        UserModel(userName: "Morgana", userAvatar: UIImage(named: "Morgana"), userPhotos: [(image: UIImage(named: "Ann"), isLiked: true, likeCount: 23), (image: UIImage(named: "Ann"), isLiked: false, likeCount: 134), (image: UIImage(named: "Ann"), isLiked: true, likeCount: 123),]),
        UserModel(userName: "Ryuji Sakamoto", userAvatar: UIImage(named: "Ryuji"), userPhotos: [(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32), (image: UIImage(named: "Ann"), isLiked: true, likeCount: 32), (image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),]),
        UserModel(userName: "Yusuke Kitagawa", userAvatar: UIImage(named: "Yusuke"), userPhotos: [(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),]),
        UserModel(userName: "Makoto Niijima", userAvatar: UIImage(named: "Makoto"), userPhotos: [(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),]),
        UserModel(userName: "Futaba Sakura", userAvatar: UIImage(named: "Futaba"), userPhotos: [(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),]),
        UserModel(userName: "Haru Okumura", userAvatar: UIImage(named: "Haru"), userPhotos: [(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),]),
        UserModel(userName: "Sumire Yoshizawa", userAvatar: UIImage(named: "Sumire"), userPhotos: [(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),]),
        UserModel(userName: "Goro Akechi", userAvatar: UIImage(named: "Goro"), userPhotos: [(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),]),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendCell
        else {
            return UITableViewCell()
        }

        let currentFriend = friends[indexPath.row]
        cell.configure(image: currentFriend.userAvatar, name: currentFriend.userName)

        return cell
    }
    
//    Отображение фотографий выбранного друга
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "showUserPhotos",
            let destination = segue.destination as? FriendPhotosController,
            let index = tableView.indexPathForSelectedRow?.row
        else {
            return
        }
        
        destination.photos = friends[index].userPhotos
    }
    
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
