//
//  AllGroupsController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 12.04.2021.
//

import UIKit
import RealmSwift

extension AllGroupsController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}

class AllGroupsController: UITableViewController {
    let searchController = UISearchController(searchResultsController: nil)
    let allGroups = try? RealmService.load(typeOf: RealmGroup.self)
    private var token: NotificationToken?
    private let photoService: PhotoService = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.photoService ?? PhotoService()
    }()
    
    var filteredGroups = [RealmGroup]()
    
    func createFilteredGroups (array: Results<RealmGroup>) {
        filteredGroups.removeAll()
        for element in array {
            filteredGroups.append(element)
        }
    }
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeRealm()

        NetworkService.instance.fetchFriendGroups(userID: Session.instance.userId) { vkGroups in
            guard let groups = vkGroups else {return}
            do {
                try RealmService.save(items: groups)
            } catch {
                print(error)
            }
        }
        
        let nib = UINib(nibName: "GroupCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "GroupCell")
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск по группам"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        token?.invalidate()
    }
    
    private func observeRealm() {
        token = allGroups?.observe({ [self] changes in
            switch changes {
            case .initial(let result):
                if result.count > 0 {
                    createFilteredGroups(array: allGroups!)
                    self.tableView.reloadData()
                }
            case .update(_, _, _, _):
                createFilteredGroups(array: allGroups!)
                self.tableView.reloadData()
            case .error(let error):
                print(error)
            }
        })
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredGroups.count
        }
        
        return allGroups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupCell
        else {
            return UITableViewCell()
        }
        
        let currentGroup: RealmGroup
        
        if isFiltering {
            currentGroup = filteredGroups[indexPath.row]
        }
        else {
            currentGroup = (allGroups?[indexPath.row])!
        }
        
        cell.configure(imageURL: currentGroup.groupAvatar, name: currentGroup.name, photoService: photoService)
        
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
        filteredGroups = allGroups!.filter { (group: RealmGroup) -> Bool in
            return group.name.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
}
