//
//  CollectionViewController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 08.04.2021.
//

import UIKit
import RealmSwift

class FriendPhotosController: UICollectionViewController {
    let photos = try? RealmService.load(typeOf: RealmPhoto.self)
    private var token: NotificationToken?
    var photosArray = [RealmPhoto]()
    
    var userID: Int?
    
    func createPhotosArray (array: Results<RealmPhoto>) {
        photosArray.removeAll()
        for element in (array.filter { $0.ownerID == self.userID}) {
            photosArray.append(element)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeRealm()
        
        if let userID = userID {
            NetworkService.instance.fetchFriendPhotos(userID: userID) { vkPhotos in
                guard let photosArray = vkPhotos else {return}
                do {
                    try RealmService.save(items: photosArray)
                } catch {
                    print(error)
                }
            }
        }
    }

    private func observeRealm() {
        token = photos?.observe({ [self] changes in
            switch changes {
            case .initial(let result):
                if result.count > 0 {
                    createPhotosArray(array: photos!)
                    self.collectionView.reloadData()
                }
            case .update(_, _, _, _):
                createPhotosArray(array: photos!)
                self.collectionView.reloadData()
            case .error(let error):
                print(error)
            }
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell
        else {
            return UICollectionViewCell()
        }
        let currentURL = photosArray[indexPath.row].sizes.first(where: { ("z").contains($0.type) ||
                                                                    ("y").contains($0.type) ||
                                                                    ("x").contains($0.type) ||
                                                                    ("w").contains($0.type)
                                                                    })?.url
        let currentIsLiked = photosArray[indexPath.row].isLiked
        let currentLikesCount = photosArray[indexPath.row].likesCount
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
        destination.photos = self.photosArray
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
