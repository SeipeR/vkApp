//
//  TableViewController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 08.04.2021.
//

import UIKit

class MyFriendsTableController: UITableViewController {
    var friends = [
        UserModel(userName: "Ann Takamaki", userAvatar: UIImage(named: "Ann")),
        UserModel(userName: "Morgana", userAvatar: UIImage(named: "Morgana")),
        UserModel(userName: "Ryuji Sakamoto", userAvatar: UIImage(named: "Ryuji")),
        UserModel(userName: "Yusuke Kitagawa", userAvatar: UIImage(named: "Yusuke")),
        UserModel(userName: "Makoto Niijima", userAvatar: UIImage(named: "Makoto")),
        UserModel(userName: "Futaba Sakura", userAvatar: UIImage(named: "Futaba")),
        UserModel(userName: "Haru Okumura", userAvatar: UIImage(named: "Haru")),
        UserModel(userName: "Sumire Yoshizawa", userAvatar: UIImage(named: "Sumire")),
        UserModel(userName: "Goro Akechi", userAvatar: UIImage(named: "Goro")),
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
    
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
