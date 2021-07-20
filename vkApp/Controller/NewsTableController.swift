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
        
//        self.tableView.separatorColor = UIColor.clear
        let nibNewsCell = UINib(nibName: "NewsCell", bundle: nil)
        let nibUserInfoCell = UINib(nibName: "NewsUserInfo", bundle: nil)
        let nibTextCell = UINib(nibName: "NewsTextCell", bundle: nil)
        let nibPhotoCell = UINib(nibName: "NewsPhotoCell", bundle: nil)
        let nibLikesCell = UINib(nibName: "NewsLikes", bundle: nil)
        tableView.register(nibNewsCell, forCellReuseIdentifier: "NewsCell")
        tableView.register(nibUserInfoCell, forCellReuseIdentifier: "NewsUserInfo")
        tableView.register(nibTextCell, forCellReuseIdentifier: "NewsTextCell")
        tableView.register(nibPhotoCell, forCellReuseIdentifier: "NewsPhotoCell")
        tableView.register(nibLikesCell, forCellReuseIdentifier: "NewsLikes")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        newsObjectArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowsCount = 4
        print(newsObjectArray[section].news.photoURL)
        if newsObjectArray[section].news.photoURL == "" {
            rowsCount -= 1
        }
        if newsObjectArray[section].news.text == "" {
            rowsCount -= 1
        }
        print(rowsCount)
        return rowsCount
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsUserInfo", for: indexPath) as? NewsUserInfo
            else {
                return UITableViewCell()
            }
            let currentNews = newsObjectArray[indexPath.section]
            cell.configure(userImage: currentNews.userAvatar, name: currentNews.user, date: Date(timeIntervalSince1970: TimeInterval(currentNews.news.date)))
            cell.separatorInset = UIEdgeInsets(top: 0, left: CGFloat.greatestFiniteMagnitude, bottom: 0, right: 0)
            return cell
        case 1:
            if newsObjectArray[indexPath.section].news.text == "" {
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: "NewsPhotoCell", for: indexPath) as? NewsPhotoCell
                else {
                    return UITableViewCell()
                }
                let currentNews = newsObjectArray[indexPath.section]
                cell.configure(newsImage: currentNews.news.photoURL)
                cell.separatorInset = UIEdgeInsets(top: 0, left: CGFloat.greatestFiniteMagnitude, bottom: 0, right: 0)
                return cell
            } else {
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTextCell", for: indexPath) as? NewsTextCell
                else {
                    return UITableViewCell()
                }
                let currentNews = newsObjectArray[indexPath.section]
                cell.configure(news: currentNews.news.text)
                cell.separatorInset = UIEdgeInsets(top: 0, left: CGFloat.greatestFiniteMagnitude, bottom: 0, right: 0)
                return cell
            }
        case 2:
            if newsObjectArray[indexPath.section].news.photoURL == "" || newsObjectArray[indexPath.section].news.text == ""{
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: "NewsLikes", for: indexPath) as? NewsLikes
                else {
                    return UITableViewCell()
                }
                let currentNews = newsObjectArray[indexPath.section]
                cell.configure(isLiked: currentNews.news.userLikes, likeCount: currentNews.news.likeCount)
                return cell
            } else {
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: "NewsPhotoCell", for: indexPath) as? NewsPhotoCell
                else {
                    return UITableViewCell()
                }
                let currentNews = newsObjectArray[indexPath.section]
                cell.configure(newsImage: currentNews.news.photoURL)
                cell.separatorInset = UIEdgeInsets(top: 0, left: CGFloat.greatestFiniteMagnitude, bottom: 0, right: 0)
                return cell
            }
        case 3:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsLikes", for: indexPath) as? NewsLikes
            else {
                return UITableViewCell()
            }
            let currentNews = newsObjectArray[indexPath.section]
            cell.configure(isLiked: currentNews.news.userLikes, likeCount: currentNews.news.likeCount)
            return cell
        default:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsLikes", for: indexPath) as? NewsLikes
            else {
                return UITableViewCell()
            }
            return cell
        }
//        guard
//            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell
//        else {
//            return UITableViewCell()
//        }
//        let currentNews = newsObjectArray[indexPath.section]
//        print(currentNews)
//
//        cell.configure(userImage: currentNews.userAvatar,
//                       name: currentNews.user,
//                       date: Date(timeIntervalSince1970: TimeInterval(currentNews.news.date)),
//                       news: currentNews.news.text,
//                       newsImage: currentNews.news.photoURL,
//                       isLiked: currentNews.news.userLikes,
//                       likeCount: currentNews.news.likeCount)
//
//
//        return cell
    }
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
