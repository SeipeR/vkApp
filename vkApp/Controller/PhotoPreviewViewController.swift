//
//  PhotoPreviewViewController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 04.05.2021.
//
import Foundation
import UIKit

class PhotoPreviewViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var photos = [(image: UIImage?, isLiked: Bool, likeCount: UInt32)]()
    var photosImage = [UIImage?]()
    var currentPhoto: UIImage?
    var currentPhotoIndex: Int = 0
    var controllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for photo in photos {
            photosImage.append(photo.image)
        }
        
        currentPhotoIndex = photosImage.firstIndex(where: {$0 === currentPhoto})!
        
        for photo in photosImage {
            let viewController = PhotoViewController(with: photo!)
            controllers.append(viewController)
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
