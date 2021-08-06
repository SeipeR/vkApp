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
    private let photoService: PhotoService = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.photoService ?? PhotoService()
    }()
    
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
        let currentURL = photosArray[indexPath.row].sizes.first(where: {
            ("z").contains($0.type) ||
            ("y").contains($0.type) ||
            ("x").contains($0.type) ||
            ("w").contains($0.type)
        })?.url
        let currentIsLiked = photosArray[indexPath.row].isLiked
        let currentLikesCount = photosArray[indexPath.row].likesCount
        cell.configure(imageURL: currentURL ?? "", likeCount: currentLikesCount, isLiked: currentIsLiked, photoService: photoService)
        
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
}
