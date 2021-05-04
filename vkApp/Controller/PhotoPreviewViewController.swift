//
//  PhotoPreviewViewController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 04.05.2021.
//

import UIKit

class PhotoPreviewViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var controllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let photos: [UIImage] = [
            UIImage(named: "Ann")!,
            UIImage(named: "Ann_1")!,
            UIImage(named: "Ann_2")!
        ]
        
        for photo in photos {
            let viewController = PhotoViewController(with: photo)
            controllers.append(viewController)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now()+2) {
            self.presentPageVC()
        }
    }
    
    func presentPageVC() {
        guard let firstViewController = controllers.first else {
            return
        }
        
        let viewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        viewController.delegate = self
        viewController.dataSource = self
        
        viewController.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        
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
