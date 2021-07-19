//
//  NewsTableController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 22.04.2021.
//

import UIKit

class NewsTableController: UITableViewController {
    
    var news = [VKNewsfeed]() {
        didSet {
            createNewsObjectArray()
            tableView.reloadData()
        }
    }
    var user = [VKUser]()
    var group = [VKGroup]()
    
    struct NewsObject {
        var news: VKNewsfeed
        var user: String
        var userAvatar: String
    }
    var newsObjectArray = [NewsObject]()
    
    func createNewsObjectArray() {
        newsObjectArray.removeAll()
        
        news.forEach { element in
            switch element.id {
            case 1...:
                guard let someUser = try? RealmService.load(typeOf: RealmUser.self).filter(NSPredicate(format: "id == %i", element.id)).first
                else { return }
                newsObjectArray.append(NewsObject(news: element,
                                                  user: someUser.fullName,
                                                  userAvatar: someUser.userAvatarURL))
            case ...0:
                guard let someGroup = try? RealmService.load(typeOf: RealmGroup.self).filter(NSPredicate(format: "id == %i", abs(element.id))).first
                else { return }
                newsObjectArray.append(NewsObject(news: element,
                                                  user: someGroup.name,
                                                  userAvatar: someGroup.groupAvatar))
            default:
                print("ERROR")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkService.instance.fetchNewsfeed(userID: Session.instance.userId) { vkNews in
            guard let news = vkNews else {return}
            self.news = news
        }
        
        let nib = UINib(nibName: "NewsCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "NewsCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        newsObjectArray.count
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
        let currentNews = newsObjectArray[indexPath.section]
        
        cell.configure(userImage: currentNews.userAvatar,
                       name: currentNews.user,
                       date: Date(timeIntervalSince1970: TimeInterval(currentNews.news.date)),
                       news: currentNews.news.text,
                       newsImage: currentNews.news.photoURL,
                       isLiked: currentNews.news.userLikes,
                       likeCount: currentNews.news.likeCount)

        return cell
    }
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
