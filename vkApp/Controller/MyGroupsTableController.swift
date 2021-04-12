//
//  MyGroupsTableController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 12.04.2021.
//

import UIKit

class MyGroupsTableController: UITableViewController {
    var groups = [
        "Revelations: Persona",
        "Persona 2: Innocent Sin",
        "Persona 2: Eternal Punishment",
        "Persona 3",
        "Persona 3 FES",
        "Persona 3 Portable",
        "Persona 4",
        "Persona 4 Golden",
        "Persona 5",
        "Persona 5 Royal",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(FriendCell.self, forCellReuseIdentifier: "FriendCell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendCell
        else {
            return UITableViewCell()
        }

        let currentFriend = groups[indexPath.row]
        cell.textLabel?.text = currentFriend
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
