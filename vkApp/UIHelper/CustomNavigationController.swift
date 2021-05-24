//
//  CustomNavigationController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 11.05.2021.
//

import UIKit

class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var isStarted = false
    var shouldFinish = false
}

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    let interactiveTransition = CustomInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        let edgePanGR = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        edgePanGR.edges = .left
        view.addGestureRecognizer(edgePanGR)
    }
    
    @objc
    private func handlePan(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            interactiveTransition.isStarted = true
            popViewController(animated: true)
        case .changed:
            guard let width = recognizer.view?.bounds.width else {
                interactiveTransition.isStarted = false
                interactiveTransition.cancel()
                return
            }
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.x / width
            let progress = max(0, min(relativeTranslation, 1))
            interactiveTransition.update(progress)
            interactiveTransition.shouldFinish = progress > 0.35
        case .ended:
            interactiveTransition.isStarted = false
            interactiveTransition.shouldFinish ? interactiveTransition.finish() : interactiveTransition.cancel()
        case .cancelled:
            interactiveTransition.isStarted = false
            interactiveTransition.cancel()
        default:
            break
        }
    }
    
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
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        interactiveTransition.isStarted ? interactiveTransition : nil
    }
}
