//
//  MyGroupsTableController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 12.04.2021.
//

import UIKit
import RealmSwift

class MyGroupsTableController: UITableViewController {
    private let groups = try? RealmService.load(typeOf: RealmGroup.self)
    private var token: NotificationToken?
    private var groupsArray = [RealmGroup]()
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard
            segue.identifier == "addGroup",
            let allGroupsController = segue.source as? AllGroupsController,
            let indexPath = allGroupsController.tableView.indexPathForSelectedRow
        else {
            return
        }
        
        let group: RealmGroup
        if allGroupsController.isFiltering {
            group = allGroupsController.filteredGroups[indexPath.row]
        } else {
            group = allGroupsController.allGroups![indexPath.row]
        }

        if !groupsArray.contains(group) {
            groupsArray.append(group)
            tableView.reloadData()
        }
    }
    
    func createGroupArray (array: Results<RealmGroup>) {
        groupsArray.removeAll()
        for element in array {
            groupsArray.append(element)
        }
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
        
        
//        navigationController?.delegate = self
    }

    private func observeRealm() {
        token = groups?.observe({ [self] changes in
            switch changes {
            case .initial(let result):
                if result.count > 0 {
                    createGroupArray(array: groups!)
                    self.tableView.reloadData()
                }
            case .update(_, _, _, _):
                createGroupArray(array: groups!)
                self.tableView.reloadData()
            case .error(let error):
                print(error)
            }
        })
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groupsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupCell
        else {
            return UITableViewCell()
        }

        let currentGroup = groupsArray[indexPath.row]
        
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
            groupsArray.remove(at: indexPath.row)
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
