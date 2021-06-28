//
//  MyGroupsTableController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 12.04.2021.
//

import UIKit

class MyGroupsTableController: UITableViewController {
//    var groups = [GroupModel(groupName: "Revelations: Persona", groupAvatar: UIImage(named: "RP")),
//                  GroupModel(groupName: "Persona 2: Innocent Sin", groupAvatar: UIImage(named: "P2IS")),]
   
    var groups = [VKGroup]() {
        didSet {
                let container = try! Container()
                try! container.write { transaction in
                    transaction.add(groups)
                }
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
        
        let group: VKGroup
        if allGroupsController.isFiltering {
            group = allGroupsController.filteredGroups[indexPath.row]
        } else {
            group = groups[indexPath.row]
        }

        if !groups.contains(group) {
            groups.append(group)
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkService.instance.fetchFriendGroups(userID: Session.instance.userId) { [weak self] vkGroups in
            guard
                let self = self,
                let groups = vkGroups
            else { return }
            self.groups = groups
        }
        
        let nib = UINib(nibName: "GroupCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "GroupCell")
        
        
//        navigationController?.delegate = self
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
        
        cell.configure(imageURL: currentGroup.groupAvatar, name: currentGroup.name)

        return cell
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

extension MyGroupsTableController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop:
            return NavigationControllerPopAnimator()
        case .push:
            return NavigationControllerPushAnimator()
        case .none:
            return nil
        default:
            return nil
        }
    }
}
