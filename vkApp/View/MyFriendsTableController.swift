//
//  TableViewController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 08.04.2021.
//

import UIKit

class MyFriendsTableController: UITableViewController {
    var friends = [
        UserModel(userName: "Ann Takamaki", userAvatar: UIImage(named: "Ann"), userPhotos: [(image: UIImage(named: "Ann_1"), isLiked: true, likeCount: 32), (image: UIImage(named: "Ann_2"), isLiked: false, likeCount: 0), (image: UIImage(named: "Ann_3"), isLiked: true, likeCount: 14), (image: UIImage(named: "Ann"), isLiked: false, likeCount: 1), (image: UIImage(named: "Ann_4"), isLiked: true, likeCount: 6), (image: UIImage(named: "Ann_5"), isLiked: false, likeCount: 56),]),
        UserModel(userName: "Morgana", userAvatar: UIImage(named: "Morgana"), userPhotos: [(image: UIImage(named: "Morgana"), isLiked: true, likeCount: 15), (image: UIImage(named: "Morgana_1"), isLiked: false, likeCount: 3), (image: UIImage(named: "Morgana_2"), isLiked: true, likeCount: 8), (image: UIImage(named: "Morgana_3"), isLiked: true, likeCount: 23), (image: UIImage(named: "Morgana_4"), isLiked: false, likeCount: 0), (image: UIImage(named: "Morgana_5"), isLiked: true, likeCount: 16),]),
        UserModel(userName: "Ryuji Sakamoto", userAvatar: UIImage(named: "Ryuji"), userPhotos: [(image: UIImage(named: "Ryuji"), isLiked: true, likeCount: 35), (image: UIImage(named: "Ryuji_1"), isLiked: false, likeCount: 3), (image: UIImage(named: "Ryuji_2"), isLiked: true, likeCount: 87), (image: UIImage(named: "Ryuji_3"), isLiked: true, likeCount: 4), (image: UIImage(named: "Ryuji_4"), isLiked: false, likeCount: 0), (image: UIImage(named: "Ryuji_5"), isLiked: true, likeCount: 6),]),
        UserModel(userName: "Yusuke Kitagawa", userAvatar: UIImage(named: "Yusuke"), userPhotos: [(image: UIImage(named: "Yusuke"), isLiked: true, likeCount: 9), (image: UIImage(named: "Yusuke_1"), isLiked: false, likeCount: 48), (image: UIImage(named: "Yusuke_2"), isLiked: true, likeCount: 1), (image: UIImage(named: "Yusuke_3"), isLiked: true, likeCount: 97),]),
        UserModel(userName: "Makoto Niijima", userAvatar: UIImage(named: "Makoto"), userPhotos: [(image: UIImage(named: "Makoto_1"), isLiked: true, likeCount: 58), (image: UIImage(named: "Makoto_2"), isLiked: false, likeCount: 88), (image: UIImage(named: "Makoto_3"), isLiked: true, likeCount: 49), (image: UIImage(named: "Makoto"), isLiked: false, likeCount: 13), (image: UIImage(named: "Makoto_4"), isLiked: true, likeCount: 7), (image: UIImage(named: "Makoto_5"), isLiked: false, likeCount: 56), (image: UIImage(named: "Makoto_6"), isLiked: true, likeCount: 9),]),
        UserModel(userName: "Futaba Sakura", userAvatar: UIImage(named: "Futaba"), userPhotos: [(image: UIImage(named: "Futaba"), isLiked: true, likeCount: 65), (image: UIImage(named: "Futaba_1"), isLiked: false, likeCount: 15), (image: UIImage(named: "Futaba_2"), isLiked: true, likeCount: 78), (image: UIImage(named: "Futaba_3"), isLiked: true, likeCount: 5), (image: UIImage(named: "Futaba_4"), isLiked: false, likeCount: 49), (image: UIImage(named: "Futaba_5"), isLiked: true, likeCount: 13),]),
        UserModel(userName: "Haru Okumura", userAvatar: UIImage(named: "Haru"), userPhotos: [(image: UIImage(named: "Haru"), isLiked: true, likeCount: 2), (image: UIImage(named: "Haru_1"), isLiked: false, likeCount: 65), (image: UIImage(named: "Haru_2"), isLiked: true, likeCount: 19), (image: UIImage(named: "Haru_3"), isLiked: true, likeCount: 37), (image: UIImage(named: "Haru_4"), isLiked: false, likeCount: 81), (image: UIImage(named: "Haru_5"), isLiked: true, likeCount: 3),]),
        UserModel(userName: "Sumire Yoshizawa", userAvatar: UIImage(named: "Sumire"), userPhotos: [(image: UIImage(named: "Sumire"), isLiked: true, likeCount: 99), (image: UIImage(named: "Sumire_1"), isLiked: false, likeCount: 43), (image: UIImage(named: "Sumire_2"), isLiked: true, likeCount: 17),]),
        UserModel(userName: "Goro Akechi", userAvatar: UIImage(named: "Goro"), userPhotos: [(image: UIImage(named: "Goro"), isLiked: true, likeCount: 1), (image: UIImage(named: "Goro_1"), isLiked: false, likeCount: 3), (image: UIImage(named: "Goro_2"), isLiked: true, likeCount: 14), (image: UIImage(named: "Goro_3"), isLiked: true, likeCount: 1), (image: UIImage(named: "Goro_4"), isLiked: false, likeCount: 0),]),
    ]
    
//    Получение массива, содержащего первые символы имени
    func createLitersArray(array: [UserModel]) -> [Character?] {
        var liters = [Character?]()
        for element in friends {
            if !(liters.contains(element.userName.first)) {
                liters.append(element.userName.first)
            }
        }
        return liters
    }
    
//    Создание словаря, группирующего друзей по первой букве имени
    func createGroupedFriendsDict(litersArray: [Character?], friendsArray: [UserModel]) -> [Character: [UserModel]] {
        var friendsDict = [Character: [UserModel]]()
        for liter in litersArray {
            var tmp = [UserModel]()
            for friend in friendsArray {
                if friend.userName.first == liter {
                    tmp.append(friend)
                }
                tmp.sort(by: {$0.userName < $1.userName})
                friendsDict[liter!] = tmp
            }
        }
        return friendsDict
    }
    
//    Структура для хранения данных словаря
    struct Objects {
        var sectionName: Character!
        var sectionObjects: [UserModel]!
    }
    
//    Массив структур
    var objectArray = [Objects]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "FriendCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "FriendCell")
//        tableView.tableHeaderView = headerView
//        tableView.tableFooterView = headerView
        
//        Преобразование данных из словаря в массив
        let groupedFriendsDict = createGroupedFriendsDict(litersArray: createLitersArray(array: friends), friendsArray: friends)
        for (key, value) in groupedFriendsDict {
            objectArray.append(Objects(sectionName: key, sectionObjects: value))
        }
        objectArray.sort(by: { $0.sectionName < $1.sectionName})
        
        NetworkService.instance.fetchFriends(userID: Session.instance.userId)
        
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
        cell.configure(image: currentFriend.userAvatar, name: currentFriend.userName)

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
        
        destination.photos = objectArray[sectionIndex].sectionObjects[rowIndex].userPhotos
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
