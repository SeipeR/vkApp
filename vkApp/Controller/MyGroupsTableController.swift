//
//  MyGroupsTableController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 12.04.2021.
//

import UIKit

class MyGroupsTableController: UITableViewController {
    var groups = [
        "Persona 5",
        "Persona 5 Royal",
    ] {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard
            segue.identifier == "addGroup",
            let allGroupsController = segue.source as? AllGroupsController,
            let indexPath = allGroupsController.tableView.indexPathForSelectedRow
        else {
            return
        }
        let group = allGroupsController.allGroups[indexPath.row]
        
        if !groups.contains(group) {
            groups.append(group)
        }
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
        cell.textLabel?.text = currentGroup
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
