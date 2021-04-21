//
//  TableViewController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 08.04.2021.
//

import UIKit

class MyFriendsTableController: UITableViewController {
    var friends = [
        UserModel(userName: "Ann Takamaki", userAvatar: UIImage(named: "Ann"), userPhotos: [(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32), (image: UIImage(named: "Ann"), isLiked: false, likeCount: 0),]),
        UserModel(userName: "Morgana", userAvatar: UIImage(named: "Morgana"), userPhotos: [(image: UIImage(named: "Ann"), isLiked: true, likeCount: 23), (image: UIImage(named: "Ann"), isLiked: false, likeCount: 134), (image: UIImage(named: "Ann"), isLiked: true, likeCount: 123),]),
        UserModel(userName: "Ryuji Sakamoto", userAvatar: UIImage(named: "Ryuji"), userPhotos: [(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32), (image: UIImage(named: "Ann"), isLiked: true, likeCount: 32), (image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),]),
        UserModel(userName: "Yusuke Kitagawa", userAvatar: UIImage(named: "Yusuke"), userPhotos: [(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),]),
        UserModel(userName: "Makoto Niijima", userAvatar: UIImage(named: "Makoto"), userPhotos: [(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),]),
        UserModel(userName: "Futaba Sakura", userAvatar: UIImage(named: "Futaba"), userPhotos: [(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),]),
        UserModel(userName: "Haru Okumura", userAvatar: UIImage(named: "Haru"), userPhotos: [(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),]),
        UserModel(userName: "Sumire Yoshizawa", userAvatar: UIImage(named: "Sumire"), userPhotos: [(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),]),
        UserModel(userName: "Goro Akechi", userAvatar: UIImage(named: "Goro"), userPhotos: [(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),(image: UIImage(named: "Ann"), isLiked: true, likeCount: 32),]),
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
