//
//  NewsTableController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 22.04.2021.
//

import UIKit

class NewsTableController: UITableViewController {
    
    var news = [VKNewsfeed]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkService.instance.fetchNewsfeed(userID: Session.instance.userId) { vkFriends in
            guard let friends = vkFriends else {return}
            do {
                self.news = friends
            } catch {
                print(error)
            }
        }
        
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
        news.sort(by: {$0.date > $1.date})
        let currentNews = news[indexPath.section]
        cell.configure(date: currentNews.date, text: currentNews.text, imageURL: currentNews.photoURL, likeCount: currentNews.likeCount, isLiked: currentNews.userLikes)

        return cell
    }
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
