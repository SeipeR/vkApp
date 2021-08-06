//
//  PhotoPreviewViewController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 04.05.2021.
//
import Foundation
import UIKit
import Kingfisher

class PhotoPreviewViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var photos = [RealmPhoto?]()
    var photosImage = [UIImage?]()
    var photosURL = [String?]()
    var currentPhoto: UIImage?
    var currentPhotoIndex: Int = 0
    var controllers = [UIViewController]()
    
    private let photoService: PhotoService = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.photoService ?? PhotoService()
    }()
    
    //    func downloadImage(with urlString: String, imageCompletionHandler: @escaping (UIImage?) -> Void) {
    //        guard let url = URL.init(string: urlString) else {
    //            return imageCompletionHandler(nil)
    //        }
    //        let resource = ImageResource(downloadURL: url)
    //        
    //        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
    //            switch result {
    //            case .success(let value):
    //                imageCompletionHandler(value.image)
    //            case .failure:
    //                imageCompletionHandler(nil)
    //            }
    //        }
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photos.forEach { photo in
            photosURL.append(photo?.bigPhotoURL ?? "")
        }
        
        photosURL.forEach { url in
            photoService.getImage(urlString: url ?? "") { [weak self] image in
                self?.photosImage.append(image)                }
        }
        
        currentPhotoIndex = photosImage.firstIndex(where: {$0 === currentPhoto})!
        
        for photo in photosImage {
            
            let viewController = PhotoViewController(with: photo!)
            self.controllers.append(viewController)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now()) {
            self.presentPageVC()
        }
    }
    
    func presentPageVC() {
        let viewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        viewController.delegate = self
        viewController.dataSource = self
        
        viewController.setViewControllers([controllers[currentPhotoIndex]], direction: .forward, animated: true, completion: nil)
        
        present(viewController, animated: true)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        let before = index - 1
        
        return controllers[before]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController), index < (controllers.count - 1) else {
            return nil
        }
        let after = index + 1
        
        return controllers[after]
    }
}
