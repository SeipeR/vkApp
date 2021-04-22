//
//  NewsTableController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 22.04.2021.
//

import UIKit

class NewsTableController: UITableViewController {
    
    var news = [
        NewsModel(userName: "Ann Takamaki", userAvatar: UIImage(named: "Ann"), newsDate: "21.01.2021", newsDescription: "This is my Persona", newsImage: (image: UIImage(named: "Ann_Persona"), isLiked: true, likeCount: 32)),
        NewsModel(userName: "Yusuke Kitagawa", userAvatar: UIImage(named: "Yusuke"), newsDate: "02.04.2021", newsDescription: "This is my Persona", newsImage: (image: UIImage(named: "Yusuke_Persona"), isLiked: false, likeCount: 19)),
        NewsModel(userName: "Morgana", userAvatar: UIImage(named: "Morgana"), newsDate: "20.12.2020", newsDescription: "This is my Persona", newsImage: (image: UIImage(named: "Morgana_Persona"), isLiked: false, likeCount: 99)),
        NewsModel(userName: "Goro Akechi", userAvatar: UIImage(named: "Goro"), newsDate: "30.03.2021", newsDescription: "This is my Persona", newsImage: (image: UIImage(named: "Goro_Persona"), isLiked: false, likeCount: 47)),
        NewsModel(userName: "Haru Okumura", userAvatar: UIImage(named: "Haru"), newsDate: "13.02.2020", newsDescription: "This is my Persona", newsImage: (image: UIImage(named: "Haru_Persona"), isLiked: true, likeCount: 36)),
        NewsModel(userName: "Makoto Nijima", userAvatar: UIImage(named: "Makoto"), newsDate: "14.07.2020", newsDescription: "This is my Persona", newsImage: (image: UIImage(named: "Makoto_Persona"), isLiked: true, likeCount: 50)),
        NewsModel(userName: "Futaba Sakura", userAvatar: UIImage(named: "Futaba"), newsDate: "17.03.2021", newsDescription: "This is my Persona", newsImage: (image: UIImage(named: "Futaba_Persona"), isLiked: true, likeCount: 67)),
        NewsModel(userName: "Ryuji Sakamoto", userAvatar: UIImage(named: "Ryuji"), newsDate: "06.04.2021", newsDescription: "This is my Persona", newsImage: (image: UIImage(named: "Ryuji_Persona"), isLiked: false, likeCount: 82)),
        NewsModel(userName: "Sumire Yoshizawa", userAvatar: UIImage(named: "Sumire"), newsDate: "19.04.2020", newsDescription: "This is my Persona", newsImage: (image: UIImage(named: "Sumire_Persona"), isLiked: true, likeCount: 11))
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
        let currentNews = news[indexPath.section]
        cell.configure(userImage: currentNews.userAvatar, name: currentNews.userName, date: currentNews.newsDate, news: currentNews.newsDescription, newsImage: currentNews.newsImage.image, isLiked: currentNews.newsImage.isLiked, likeCount: currentNews.newsImage.likeCount)

        return cell
    }
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
