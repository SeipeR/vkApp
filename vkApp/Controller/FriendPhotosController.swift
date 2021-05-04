//
//  CollectionViewController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 08.04.2021.
//

import UIKit

class FriendPhotosController: UICollectionViewController {
    
    var photos = [(image: UIImage?, isLiked: Bool, likeCount: UInt32)]()

    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        let currentGroupImage = photos[indexPath.row].image
        let currentGroupIsLiked = photos[indexPath.row].isLiked
        let currentGroupLikeCount = photos[indexPath.row].likeCount
        cell.configure(image: currentGroupImage, isLiked: currentGroupIsLiked, likeCount: currentGroupLikeCount)


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
