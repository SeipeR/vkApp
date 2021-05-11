//
//  NewsModel.swift
//  vkApp
//
//  Created by Дамир Доронкин on 22.04.2021.
//

import UIKit

struct NewsModel {
    var userName: String
    var userAvatar: UIImage?
    var newsDate: String
    var newsDescription: String
    var newsImage: (image: UIImage?, isLiked: Bool, likeCount: UInt32)
}
