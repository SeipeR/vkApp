//
//  MyGroupsTableController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 12.04.2021.
//

import UIKit

class MyGroupsTableController: UITableViewController {
    var groups = [
        GroupModel(groupName: "Persona 5", groupAvatar: UIImage(named: "VK_logo")!),
        GroupModel(groupName: "Persona 5 Royal", groupAvatar: UIImage(named: "VK_logo")!),
    ]
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard
            segue.identifier == "addGroup",
            let allGroupsController = segue.source as? AllGroupsController,
            let indexPath = allGroupsController.tableView.indexPathForSelectedRow
        else {
            return
        }
        let group = allGroupsController.allGroups[indexPath.row]
        var tmp = groups
        for i in (0 ..< groups.count) {
            if !tmp[i].groupName.contains(group.groupName) {
                tmp.append(group)
            }
        }
        groups = tmp
        tableView.reloadData()
        
//        if !groups[indexPath.row].groupName.contains(group.groupName) {
//            groups.append(group)
//            tableView.reloadData()
//        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.register(GroupCell.self, forCellReuseIdentifier: "GroupCell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupCell
        else {
            return UITableViewCell()
        }

        let currentGroup = groups[indexPath.row]
        cell.textLabel?.text = currentGroup.groupName
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}
