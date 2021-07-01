//
//  CollectionViewController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 08.04.2021.
//

import UIKit
import RealmSwift

class FriendPhotosController: UICollectionViewController {
    var realmResultUserPhoto: Results<RealmPhoto>? = try? RealmService.load(typeOf: RealmPhoto.self)
    var photos = [RealmPhoto]() {
        didSet {
            realmResultUserPhoto = try? RealmService.load(typeOf: RealmPhoto.self)
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
        let currentURL = photos[indexPath.row].sizes.first(where: { ("z").contains($0.type) ||
                                                                    ("y").contains($0.type) ||
                                                                    ("x").contains($0.type) ||
                                                                    ("w").contains($0.type)
                                                                    })?.url
        let currentIsLiked = photos[indexPath.row].isLiked
        let currentLikesCount = photos[indexPath.row].likesCount
        cell.configure(imageURL: currentURL ?? "", likeCount: currentLikesCount, isLiked: currentIsLiked)

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
