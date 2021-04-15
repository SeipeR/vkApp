//
//  TableViewController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 08.04.2021.
//

import UIKit

class MyFriendsTableController: UITableViewController {
    var friends = [
        UserModel(userName: "Ann Takamaki", userAvatar: UIImage(named: "Ann"), userPhotos: [UIImage(named: "Ann"), UIImage(named: "Ann"),]),
        UserModel(userName: "Morgana", userAvatar: UIImage(named: "Morgana"), userPhotos: [UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"),]),
        UserModel(userName: "Ryuji Sakamoto", userAvatar: UIImage(named: "Ryuji"), userPhotos: [UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"),]),
        UserModel(userName: "Yusuke Kitagawa", userAvatar: UIImage(named: "Yusuke"), userPhotos: [UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"),]),
        UserModel(userName: "Makoto Niijima", userAvatar: UIImage(named: "Makoto"), userPhotos: [UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"),]),
        UserModel(userName: "Futaba Sakura", userAvatar: UIImage(named: "Futaba"), userPhotos: [UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"),]),
        UserModel(userName: "Haru Okumura", userAvatar: UIImage(named: "Haru"), userPhotos: [UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"),]),
        UserModel(userName: "Sumire Yoshizawa", userAvatar: UIImage(named: "Sumire"), userPhotos: [UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"),]),
        UserModel(userName: "Goro Akechi", userAvatar: UIImage(named: "Goro"), userPhotos: [UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"), UIImage(named: "Ann"),]),
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
