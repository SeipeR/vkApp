//
//  AllGroupsController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 12.04.2021.
//

import UIKit

extension AllGroupsController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}

class AllGroupsController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
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
    
    var filteredGroups: [GroupModel] = []
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "GroupCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "GroupCell")
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск по группам"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredGroups.count
        }
        
        return allGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupCell
        else {
            return UITableViewCell()
        }
        
        let currentGroup: GroupModel
        
        if isFiltering {
            currentGroup = filteredGroups[indexPath.row]
        } else {
            currentGroup = allGroups[indexPath.row]
        }
        
        cell.configure(image: currentGroup.groupAvatar, name: currentGroup.groupName)

        return cell
    }
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "addGroup", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2) {
            if let cell = tableView.cellForRow(at: indexPath) as? GroupCell {
                cell.groupAvatarImage.transform = .init(scaleX: 0.95, y: 0.95)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 1.5, delay: 0.2, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.0) {
            if let cell = tableView.cellForRow(at: indexPath) as? GroupCell {
                cell.groupAvatarImage.transform = .identity
            }
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredGroups = allGroups.filter { (group: GroupModel) -> Bool in
            return group.groupName.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
}
