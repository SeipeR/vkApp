//
//  TableViewController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 08.04.2021.
//

import UIKit
import RealmSwift

class MyFriendsTableController: UITableViewController {
    private let friends = try? RealmService.load(typeOf: RealmUser.self)
    private var token: NotificationToken?
    private var userToken: NotificationToken?

//    Получение массива, содержащего первые символы имени
    func createLitersArray(array: Results<RealmUser>) -> [Character?] {
        var liters = [Character?]()
        for element in array {
            if !(liters.contains(element.fullName.first)) {
                liters.append(element.fullName.first)
            }
        }
        return liters
    }
    
//    Создание словаря, группирующего друзей по первой букве имени
    func createGroupedFriendsDict(litersArray: [Character?], friendsArray: Results<RealmUser>) -> [Character: [RealmUser]] {
        var friendsDict = [Character: [RealmUser]]()
        for liter in litersArray {
            var tmp = [RealmUser]()
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
        var sectionObjects: [RealmUser]!
    }
    
//    Массив структур
    var objectArray = [Objects]()
    
    func createObjectArray() {
        objectArray.removeAll()
        
        let groupedFriendsDict = createGroupedFriendsDict(litersArray: createLitersArray(array: friends!), friendsArray: friends!)
        for (key, value) in groupedFriendsDict {
            objectArray.append(Objects(sectionName: key, sectionObjects: value))
        }
        objectArray.sort(by: { $0.sectionName < $1.sectionName})
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        observeRealm()
//        observeUser()
        
        let nib = UINib(nibName: "FriendCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "FriendCell")
        
        NetworkService.instance.fetchFriends(userID: Session.instance.userId) { vkFriends in
            guard let friends = vkFriends else {return}
            do {
                try RealmService.save(items: friends)
            } catch {
                print(error)
            }
        }
        
//        createObjectArray()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        modify()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        token?.invalidate()
    }

    private func observeRealm() {
        token = friends?.observe({ [self] changes in
            switch changes {
            case .initial(let result):
                if result.count > 0 {
                    createObjectArray()
                    self.tableView.reloadData()
                }
            case .update(_, _, _, _):
                createObjectArray()
                self.tableView.reloadData()
            case .error(let error):
                print(error)
            }
        })
    }
    
//    private func observeUser() {
//        guard let someUser = try? RealmService.load(typeOf: RealmUser.self).filter(NSPredicate(format: "id == %i", 44227941)).first
//        else { return }
//        userToken = someUser.observe({ changes in
//            switch changes {
//            case let .change(object, property):
//                guard
//                    let users = self.friends,
//                    let index = users.enumerated().first(where: { $0.element.id == 44227941 })?.offset,
//                    let visibleRows = self.tableView.indexPathsForVisibleRows
//                else {
//                    return self.tableView.reloadData()
//                }
//                let indexPath = IndexPath(row: index, section: 0)
//                if visibleRows.contains(indexPath) {
//                    self.tableView.reloadRows(at: [indexPath], with: .fade)
//                }
//            case .deleted:
//                print("\(someUser.fullName) try to delete")
//            case .error(let error):
//                print(error)
//            }
//        })
//    }
    
//    Поиск пользователя через id
    private func modify() {
        let someUser = try? RealmService.load(typeOf: RealmUser.self).filter(NSPredicate(format: "id == %i", 44227941))
//        print(someUser ?? "")
        if let currentUser = someUser?.first {
            do {
                let realm = try Realm()
//                realm.beginWrite()
//                currentUser.firstName = "Damir"
//                try realm.commitWrite()
                try realm.write {
                    currentUser.firstName = "Damir"
                }
            } catch {
                print(error)
            }
        }
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
        
        destination.userID = objectArray[sectionIndex].sectionObjects[rowIndex].id
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
