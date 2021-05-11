//
//  NewsTableController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 22.04.2021.
//

import UIKit

class NewsTableController: UITableViewController {
    
    var news = [
        NewsModel(userName: "Ann Takamaki", userAvatar: UIImage(named: "Ann"), newsDate: "2021.01.21", newsDescription: "This is my Persona", newsImage: (image: UIImage(named: "Ann_Persona"), isLiked: true, likeCount: 32)),
        NewsModel(userName: "Yusuke Kitagawa", userAvatar: UIImage(named: "Yusuke"), newsDate: "2021.04.02", newsDescription: "This is my Persona", newsImage: (image: UIImage(named: "Yusuke_Persona"), isLiked: false, likeCount: 19)),
        NewsModel(userName: "Morgana", userAvatar: UIImage(named: "Morgana"), newsDate: "2020.12.20", newsDescription: "This is my Persona", newsImage: (image: UIImage(named: "Morgana_Persona"), isLiked: false, likeCount: 99)),
        NewsModel(userName: "Goro Akechi", userAvatar: UIImage(named: "Goro"), newsDate: "2021.03.30", newsDescription: "This is my Persona", newsImage: (image: UIImage(named: "Goro_Persona"), isLiked: false, likeCount: 47)),
        NewsModel(userName: "Haru Okumura", userAvatar: UIImage(named: "Haru"), newsDate: "2020.02.13", newsDescription: "This is my Persona", newsImage: (image: UIImage(named: "Haru_Persona"), isLiked: true, likeCount: 36)),
        NewsModel(userName: "Makoto Nijima", userAvatar: UIImage(named: "Makoto"), newsDate: "2020.07.14", newsDescription: "This is my Persona", newsImage: (image: UIImage(named: "Makoto_Persona"), isLiked: true, likeCount: 50)),
        NewsModel(userName: "Futaba Sakura", userAvatar: UIImage(named: "Futaba"), newsDate: "2021.03.17", newsDescription: "This is my Persona", newsImage: (image: UIImage(named: "Futaba_Persona"), isLiked: true, likeCount: 67)),
        NewsModel(userName: "Ryuji Sakamoto", userAvatar: UIImage(named: "Ryuji"), newsDate: "2021.04.06", newsDescription: "This is my Persona", newsImage: (image: UIImage(named: "Ryuji_Persona"), isLiked: false, likeCount: 82)),
        NewsModel(userName: "Sumire Yoshizawa", userAvatar: UIImage(named: "Sumire"), newsDate: "2020.04.19", newsDescription: "This is my Persona", newsImage: (image: UIImage(named: "Sumire_Persona"), isLiked: true, likeCount: 11))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "NewsCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "NewsCell")
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
        news.sort(by: {$0.newsDate > $1.newsDate})
        let currentNews = news[indexPath.section]
        cell.configure(userImage: currentNews.userAvatar, name: currentNews.userName, date: currentNews.newsDate, news: currentNews.newsDescription, newsImage: currentNews.newsImage.image, isLiked: currentNews.newsImage.isLiked, likeCount: currentNews.newsImage.likeCount)

        return cell
    }
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
