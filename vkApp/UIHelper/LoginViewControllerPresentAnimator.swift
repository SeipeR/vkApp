//
//  Animator.swift
//  vkApp
//
//  Created by Дамир Доронкин on 11.05.2021.
//

import UIKit

class LoginViewControllerPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let animationTime: TimeInterval = 0.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animationTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else {
            return
        }
        
        transitionContext.containerView.addSubview(destination.view)
        
        destination.view.frame = transitionContext.containerView.frame
        
        destination.view.transform = CGAffineTransform(translationX: source.view.bounds.width, y: 0)
        
        UIView.animate(withDuration: animationTime) {
            destination.view.transform = .identity
        } completion: { complete in
            transitionContext.completeTransition(complete)
        }

    }
}

class LoginViewControllerDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let animationTime: TimeInterval = 0.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animationTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else {
            return
        }
        
        transitionContext.containerView.addSubview(destination.view)
        
        destination.view.frame = transitionContext.containerView.frame
        
        destination.view.transform = CGAffineTransform(translationX: -source.view.bounds.width, y: 0)
        
        UIView.animate(withDuration: animationTime) {
            destination.view.transform = .identity
        } completion: { complete in
            transitionContext.completeTransition(complete)
        }

    }
}
