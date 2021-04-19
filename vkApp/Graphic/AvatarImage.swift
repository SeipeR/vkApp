//
//  AvatarImage.swift
//  vkApp
//
//  Created by Дамир Доронкин on 14.04.2021.
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
//
//class UserAvatar: UIView {
//    var logoView = UIImageView()
//    let shadowView = UIView()
//
//    @IBInspectable var shadowRadius: CGFloat = 25.0 {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
//
//    @IBInspectable var shadowBlur: CGFloat = 6.0 {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
//
//    @IBInspectable var shadowOpacity: Float = 0.3 {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
//
//    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 5) {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
//
//    @IBInspectable var shadowColor: UIColor = .red {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
//
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//
//        logoView.frame = rect
//        logoView.backgroundColor = .clear
//        logoView.layer.cornerRadius = shadowRadius
//        logoView.clipsToBounds = true
//        logoView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
//
//        shadowView.frame = rect
//        shadowView.backgroundColor = .clear
//        shadowView.clipsToBounds = false
//        shadowView.layer.shadowColor = shadowColor.cgColor
//        shadowView.layer.shadowOpacity = shadowOpacity
//        shadowView.layer.shadowOffset = shadowOffset
//        shadowView.layer.shadowRadius = shadowBlur
//        shadowView.layer.shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: shadowRadius).cgPath
//
//        shadowView.addSubview(logoView)
//        self.addSubview(shadowView)
//    }
//}
