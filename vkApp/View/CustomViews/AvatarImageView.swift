//
//  AvatarImageView.swift
//  vkApp
//
//  Created by Дамир Доронкин on 19.04.2021.
//

import UIKit

class AvatarImage: UIImageView {
    @IBInspectable var borderColor: UIColor = .gray
    @IBInspectable var borderWith: CGFloat = 1.0
    
    override func awakeFromNib() {
        self.backgroundColor = .white
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWith
        self.layer.borderColor = borderColor.cgColor
    }
}

class AvatarBackShadow: UIView {
    @IBInspectable var shadowColor: UIColor = .gray
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 3.0, height: 3.0)
    @IBInspectable var shadowOpacity: Float = 0.9
    @IBInspectable var shadowRadius: CGFloat = 3

    override func awakeFromNib() {
        self.backgroundColor = .clear
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
    }
}
