//
//  TableViewController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 08.04.2021.
//

import UIKit

class MyFriendsTableController: UITableViewController {
    var friends = [
        "Ann Takamaki",
        "Morgana",
        "Ryuji Sakamoto",
        "Yusuke Kitagawa",
        "Makoto Niijima",
        "Futaba Sakura",
        "Haru Okumura",
        "Sumire Yoshizawa",
        "Goro Akechi",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(FriendCell.self, forCellReuseIdentifier: "FriendCell")
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
        cell.textLabel?.text = currentFriend
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
