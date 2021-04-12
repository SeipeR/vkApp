//
//  TableViewController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 08.04.2021.
//

import UIKit

class MyFriendsTableController: UITableViewController {
    var friends = [
        UserModel(userName: "Ann Takamaki", userAvatar: UIImage(named: "VK_logo")!),
        UserModel(userName: "Morgana", userAvatar: UIImage(named: "VK_logo")!),
        UserModel(userName: "Ryuji Sakamoto", userAvatar: UIImage(named: "VK_logo")!),
        UserModel(userName: "Yusuke Kitagawa", userAvatar: UIImage(named: "VK_logo")!),
        UserModel(userName: "Makoto Niijima", userAvatar: UIImage(named: "VK_logo")!),
        UserModel(userName: "Futaba Sakura", userAvatar: UIImage(named: "VK_logo")!),
        UserModel(userName: "Haru Okumura", userAvatar: UIImage(named: "VK_logo")!),
        UserModel(userName: "Sumire Yoshizawa", userAvatar: UIImage(named: "VK_logo")!),
        UserModel(userName: "Goro Akechi", userAvatar: UIImage(named: "VK_logo")!),
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

        let currentFriend = friends[indexPath.row].userName
        cell.textLabel?.text = currentFriend
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
