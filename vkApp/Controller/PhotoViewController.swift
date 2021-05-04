//
//  PhotoViewController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 04.05.2021.
//

import UIKit

class PhotoViewController: UIViewController {

    let image: UIImage
    
    private let myView: UIView = {
        let myView = UIView()
        myView.translatesAutoresizingMaskIntoConstraints = false
        return myView
    }()
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init(with image: UIImage) {
        self.image = image
        myImageView.image = self.image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(self.myView)
        myView.addSubview(self.myImageView)
        addConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myImageView.frame = myView.bounds
    }
    
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(myView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(myView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(myView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(myView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        
        constraints.append(myImageView.widthAnchor.constraint(equalTo: myView.widthAnchor, multiplier: 0.95))
        constraints.append(myImageView.heightAnchor.constraint(equalTo: myView.heightAnchor, multiplier: 0.85))
        constraints.append(myImageView.centerYAnchor.constraint(equalTo: myView.centerYAnchor))
        constraints.append(myImageView.centerXAnchor.constraint(equalTo: myView.centerXAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
}
