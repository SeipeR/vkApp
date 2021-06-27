//
//  TableViewController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 08.04.2021.
//

import UIKit
import RealmSwift

class MyFriendsTableController: UITableViewController {
    var realmResultUser: Results<RealmUser>? = try? RealmService.load(typeOf: RealmUser.self)
    var friends: [VKUser] = [] {
        didSet {
            for friend in friends {
                let container = try! Container()
                try! container.write { transaction in
                    transaction.add(friend)
                }
            }
           
            //        Преобразование данных из словаря в массив
            let groupedFriendsDict = createGroupedFriendsDict(litersArray: createLitersArray(array: friends), friendsArray: friends)
            for (key, value) in groupedFriendsDict {
                objectArray.append(Objects(sectionName: key, sectionObjects: value))
            }
            objectArray.sort(by: { $0.sectionName < $1.sectionName})
            
            tableView.reloadData()
        }
    }
    
//    Получение массива, содержащего первые символы имени
    func createLitersArray(array: [VKUser]) -> [Character?] {
        var liters = [Character?]()
        for element in friends {
            if !(liters.contains(element.fullName.first)) {
                liters.append(element.fullName.first)
            }
        }
        return liters
    }
    
//    Создание словаря, группирующего друзей по первой букве имени
    func createGroupedFriendsDict(litersArray: [Character?], friendsArray: [VKUser]) -> [Character: [VKUser]] {
        var friendsDict = [Character: [VKUser]]()
        for liter in litersArray {
            var tmp = [VKUser]()
            for friend in friendsArray {
                if friend.fullName.first == liter {
                    tmp.append(friend)
                }
                tmp.sort(by: {$0.fullName < $1.fullName})
                friendsDict[liter!] = tmp
            }
        }
        return friendsDict
    }
    
//    Структура для хранения данных словаря
    struct Objects {
        var sectionName: Character!
        var sectionObjects: [VKUser]!
    }
    
//    Массив структур
    var objectArray = [Objects]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let user = RealmUser()
//        user.id = 0
//        user.firstName = "Firstname"
//        user.lastName = "Surname"
//        try? RealmService.save(items: [user])
//        let users = try? RealmService.load(typeOf: RealmUser.self)  //  получение данных из БД
        
        let nib = UINib(nibName: "FriendCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "FriendCell")
//        tableView.tableHeaderView = headerView
//        tableView.tableFooterView = headerView
        
        NetworkService.instance.fetchFriends(userID: Session.instance.userId) { [weak self] vkFriends in
            guard
                let self = self,
                let friends = vkFriends
            else {return}
            self.friends = friends
        }
        
//        navigationController?.delegate = self
    }

    // MARK: - Table view data source

//    Количество секций в таблице
    override func numberOfSections(in tableView: UITableView) -> Int {
        return objectArray.count
    }
    
//    Количество строк для конкретной секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray[section].sectionObjects.count
    }
    
//    Заголовок для секции
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return String(objectArray[section].sectionName)
//    }
    
//    Данные для использования в ячейке
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendCell
        else {
            return UITableViewCell()
        }
        let currentFriend = objectArray[indexPath.section].sectionObjects[indexPath.row]
        cell.configure(imageURL: currentFriend.userAvatarURL, name: currentFriend.fullName)

        return cell
    }
    
//    Отображение фотографий выбранного друга
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "showUserPhotos",
            let destination = segue.destination as? FriendPhotosController,
            let sectionIndex = tableView.indexPathForSelectedRow?.section,
            let rowIndex = tableView.indexPathForSelectedRow?.row
        else {
            return
        }
        
//        destination.photos = objectArray[sectionIndex].sectionObjects[rowIndex].userPhotos
    }
    
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showUserPhotos", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
//     Добавление хэдера и футера
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = TableSectionHeaderView(reuseIdentifier: "")
        headerView.configure(with: objectArray[section].sectionName)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2) {
            if let cell = tableView.cellForRow(at: indexPath) as? FriendCell {
                cell.friendAvatarImage.transform = .init(scaleX: 0.95, y: 0.95)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 1.5, delay: 0.2, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.0) {
            if let cell = tableView.cellForRow(at: indexPath) as? FriendCell {
                cell.friendAvatarImage.transform = .identity
            }
        }
    }
    
//    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let headerView = TableSectionHeaderView(reuseIdentifier: "")
//        headerView.configure(with: "Footer")
//        return headerView
//    }
//
//    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        70
//    }
}


extension MyFriendsTableController: UINavigationControllerDelegate {
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
