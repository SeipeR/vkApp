//
//  NewsTableController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 22.04.2021.
//

import UIKit

class NewsTableController: UITableViewController {
    
    var news = [
        NewsModel(userName: "Ann Takamaki", userAvatar: UIImage(named: "Ann"), newsDate: "21.01.2021", newsDescription: "Persona User Ann", newsImage: (image: UIImage(named: "Ann"), isLiked: true, likeCount: 32)),
        NewsModel(userName: "Yusuke Kitagawa", userAvatar: UIImage(named: "Yusuke"), newsDate: "02.04.2021", newsDescription: "Persona User Yusuke", newsImage: (image: UIImage(named: "Yusuke"), isLiked: false, likeCount: 19)),
        NewsModel(userName: "Morgana", userAvatar: UIImage(named: "Morgana"), newsDate: "20.12.2020", newsDescription: "Persona User Morgana", newsImage: (image: UIImage(named: "Morgana"), isLiked: true, likeCount: 99))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "NewsCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "NewsCell")
        news.sort(by: { $0.newsDate < $1.newsDate})
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        news.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell
        else {
            return UITableViewCell()
        }
        let currentNews = news[indexPath.section]
        cell.configure(userImage: currentNews.userAvatar, name: currentNews.userName, date: currentNews.newsDate, news: currentNews.newsDescription, newsImage: currentNews.newsImage.image, isLiked: currentNews.newsImage.isLiked, likeCount: currentNews.newsImage.likeCount)

        return cell
    }
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
