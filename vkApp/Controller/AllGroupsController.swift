//
//  AllGroupsController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 12.04.2021.
//

import UIKit

class AllGroupsController: UITableViewController {
    let allGroups = [
        "Revelations: Persona",
        "Persona 2: Innocent Sin",
        "Persona 2: Eternal Punishment",
        "Persona 3",
        "Persona 3 FES",
        "Persona 3 Portable",
        "Persona 4",
        "Persona 4 Golden",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupsCell", for: indexPath) as? GroupCell
        else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = allGroups[indexPath.row]
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
