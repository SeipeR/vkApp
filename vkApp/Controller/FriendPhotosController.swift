//
//  CollectionViewController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 08.04.2021.
//

import UIKit
import RealmSwift

class FriendPhotosController: UICollectionViewController {
//    var realmResultUserPhoto: Results<RealmPhoto>? = try? RealmService.load(typeOf: RealmPhoto.self)
//    var realmFriends = [RealmUser]()
//    var friends: [VKUser] = []
//    {
//        didSet {
//            let container = try! Container()
//            try? container.write { transaction in
//                transaction.add(friends)
//            }
//
//            realmResultUser = try? RealmService.load(typeOf: RealmUser.self)
//            realmFriends = addFriendsToRealmArray(results: realmResultUser)
//
//            //        Преобразование данных из словаря в массив
//            let groupedFriendsDict = createGroupedFriendsDict(litersArray: createLitersArray(array: realmFriends), friendsArray: realmFriends)
//            for (key, value) in groupedFriendsDict {
//                objectArray.append(Objects(sectionName: key, sectionObjects: value))
//            }
//            objectArray.sort(by: { $0.sectionName < $1.sectionName})
//
//            tableView.reloadData()
//        }
//    }
//    func addFriendsToRealmArray (results: Results<RealmUser>?) -> [RealmUser] {
//        var array = [RealmUser]()
//        results?.forEach({ result in
//            array.append(result)
//        })
//        return array
//    }
    var photos = [VKPhoto]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var userID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userID = userID {
            NetworkService.instance.fetchFriendPhotos(userID: userID) { [weak self] vkPhotos in
                guard
                    let self = self,
                    let photos = vkPhotos
                else {return}
                print(photos)
                self.photos = photos
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell
        else {
            return UICollectionViewCell()
        }
        
//        let currentGroupImage = photos[indexPath.row].image
//        let currentGroupIsLiked = photos[indexPath.row].isLiked
//        let currentGroupLikeCount = photos[indexPath.row].likeCount
        cell .configure(imageURL: photos[indexPath.row]
                            .sizes
                            .first(where: { (400..<650).contains($0.width) })?
                            .url ?? "")

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "goPhoto",
            let destination = segue.destination as? PhotoPreviewViewController,
            let cell: PhotoCell = sender as? PhotoCell,
            let image = cell.photo.image
        else {
            return
        }
        destination.currentPhoto = image
        destination.photos = self.photos
    }


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
