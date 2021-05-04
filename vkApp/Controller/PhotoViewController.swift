//
//  PhotoViewController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 04.05.2021.
//

import UIKit

class PhotoViewController: UIViewController {

    let image: UIImage
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBackground
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
        view.addSubview(self.myImageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myImageView.frame = view.bounds
    }
}
