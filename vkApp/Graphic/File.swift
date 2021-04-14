//
//  File.swift
//  vkApp
//
//  Created by Дамир Доронкин on 14.04.2021.
//

import UIKit

class TestViewController: UIViewController {
    let testView = TestView(frame: CGRect(x: 200.0, y: 200.0, width: 100.0, height: 100.0))
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(testView)
        testView.backgroundColor = .red
    }
}

class TestView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
//        context.setFillColor(UIColor.systemOrange.cgColor)
//        context.fill(CGRect(x: 0.0, y: 0.0, width: 70.0, height: 70.0))
        context.setStrokeColor(UIColor.red.cgColor)
        context.move(to: CGPoint(x: <#T##CGFloat#>, y: <#T##CGFloat#>))
    }
}
