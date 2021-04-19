//
//  AllGroupsController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 12.04.2021.
//

import UIKit

class AllGroupsController: UITableViewController {
    let allGroups = [
        GroupModel(groupName: "Revelations: Persona", groupAvatar: UIImage(named: "RP")),
        GroupModel(groupName: "Persona 2: Innocent Sin", groupAvatar: UIImage(named: "P2IS")),
        GroupModel(groupName: "Persona 2: Eternal Punishment", groupAvatar: UIImage(named: "P2EP")),
        GroupModel(groupName: "Persona 3", groupAvatar: UIImage(named: "P3")),
        GroupModel(groupName: "Persona 3 FES", groupAvatar: UIImage(named: "P3F")),
        GroupModel(groupName: "Persona 3 Portable", groupAvatar: UIImage(named: "P3P")),
        GroupModel(groupName: "Persona 4", groupAvatar: UIImage(named: "P4")),
        GroupModel(groupName: "Persona 5", groupAvatar: UIImage(named: "P5")),
        GroupModel(groupName: "Persona 5 Royal", groupAvatar: UIImage(named: "P5R")),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupsCell", for: indexPath) as? GroupCell
        else {
            return UITableViewCell()
        }
        
        let currentGroup = allGroups[indexPath.row]
        
        cell.configure(image: currentGroup.groupAvatar, name: currentGroup.groupName)


        return cell
    }
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
