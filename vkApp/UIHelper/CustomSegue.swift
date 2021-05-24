//
//  CustomSegue.swift
//  vkApp
//
//  Created by Дамир Доронкин on 11.05.2021.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    let animationTime: TimeInterval = 0.5
    
    override func perform() {
        guard let containerView = source.view else {
            return
        }
        
        containerView.addSubview(destination.view)
        destination.view.frame = containerView.frame
        
        destination.view.transform = CGAffineTransform(translationX: 0, y: -source.view.bounds.height)
        
        UIView.animate(withDuration: animationTime) {
            self.destination.view.transform = .identity
        } completion: { _ in
            self.source.present(self.destination, animated: false)
        }
    }
}
