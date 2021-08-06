//
//  NewsTableController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 22.04.2021.
//

import UIKit

class NewsTableController: UITableViewController {
    
    private let photoService: PhotoService = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.photoService ?? PhotoService()
    }()
    
    var news = [VKNewsfeed]() {
        didSet {
            newsObjectArray = createNewsObjectArray(array: news)
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
    
    private var nextFrom = ""
    private var isLoading = false
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "d MMM y HH:mm:ss"
        return df
    }()
    
    private func getNews() {
        NetworkService.instance.fetchNewsfeed(userID: Session.instance.userId, startFrom: nextFrom) { [weak self] (vkNews, nextFrom)  in
            self?.nextFrom = nextFrom
            guard let news = vkNews else {return}
            self?.news = news
        }
    }
    
    private func createNewsObjectArray(array: [VKNewsfeed]) -> [NewsObject] {
        var tempArray = [NewsObject]()
        
        array.forEach { element in
            switch element.id {
            case 1...:
                guard let someUser = try? RealmService.load(typeOf: RealmUser.self).filter(NSPredicate(format: "id == %i", element.id)).first
                else { return }
                tempArray.append(NewsObject(news: element,
                                            user: someUser.fullName,
                                            userAvatar: someUser.userAvatarURL))
            case ...0:
                guard let someGroup = try? RealmService.load(typeOf: RealmGroup.self).filter(NSPredicate(format: "id == %i", abs(element.id))).first
                else { return }
                tempArray.append(NewsObject(news: element,
                                            user: someGroup.name,
                                            userAvatar: someGroup.groupAvatar))
            default:
                print("ERROR")
            }
        }
        return tempArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNews()
        
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
        
        makeRefreshControl()
        configPrefetch()
    }
    
    private func configPrefetch() {
        tableView.prefetchDataSource = self
    }
    
    private func makeRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(
            self,
            action: #selector(refresh),
            for: .valueChanged)
    }
    
    @objc private func refresh() {
        self.tableView.refreshControl?.beginRefreshing()
        let mostFreshNewsDate = self.newsObjectArray.first?.news.date ?? Int(Date().timeIntervalSince1970)
        NetworkService.instance.fetchNewsfeed(userID: Session.instance.userId, startTime: mostFreshNewsDate + 1) { [weak self] (vkNews, nextFrom)  in
            guard let self = self else { return }
            var someArray = [NewsObject]()
            self.tableView.refreshControl?.endRefreshing()
            guard vkNews!.count > 0 else { return }
            someArray = self.createNewsObjectArray(array: vkNews!)
            self.newsObjectArray = someArray + self.newsObjectArray
            let indexSet = IndexSet(integersIn: 0 ..< vkNews!.count)
            self.tableView.insertSections(indexSet, with: .automatic)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        newsObjectArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowsCount = 4
        if newsObjectArray[section].news.photoURL == "" {
            rowsCount -= 1
        }
        if newsObjectArray[section].news.text == "" {
            rowsCount -= 1
        }
        return rowsCount
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentNews = newsObjectArray[indexPath.section]
        
        switch indexPath.row {
        case 0:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsUserInfo", for: indexPath) as? NewsUserInfo
            else {
                return UITableViewCell()
            }
            let date = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(currentNews.news.date)))
            cell.configure(userImage: currentNews.userAvatar, name: currentNews.user, date: date)
            cell.separatorInset = UIEdgeInsets(top: 0, left: CGFloat.greatestFiniteMagnitude, bottom: 0, right: 0)
            return cell
        case 1:
            if newsObjectArray[indexPath.section].news.text == "" {
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: "NewsPhotoCell", for: indexPath) as? NewsPhotoCell
                else {
                    return UITableViewCell()
                }
                cell.configure(newsImage: currentNews.news.photoURL, photoService: photoService)
                cell.separatorInset = UIEdgeInsets(top: 0, left: CGFloat.greatestFiniteMagnitude, bottom: 0, right: 0)
                return cell
            } else {
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTextCell", for: indexPath) as? NewsTextCell
                else {
                    return UITableViewCell()
                }
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
                cell.configure(isLiked: currentNews.news.userLikes, likeCount: currentNews.news.likeCount)
                return cell
            } else {
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: "NewsPhotoCell", for: indexPath) as? NewsPhotoCell
                else {
                    return UITableViewCell()
                }
                cell.configure(newsImage: currentNews.news.photoURL, photoService: photoService)
                cell.separatorInset = UIEdgeInsets(top: 0, left: CGFloat.greatestFiniteMagnitude, bottom: 0, right: 0)
                return cell
            }
        case 3:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsLikes", for: indexPath) as? NewsLikes
            else {
                return UITableViewCell()
            }
            cell.configure(isLiked: currentNews.news.userLikes, likeCount: currentNews.news.likeCount)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableWidth = tableView.bounds.width
        let currentNews = newsObjectArray[indexPath.section]
        
        switch indexPath.row {
        case 1 where newsObjectArray[indexPath.section].news.text == "":
            return (tableWidth / currentNews.news.photosAspectRatio)
        case 2 where ((newsObjectArray[indexPath.section].news.photoURL != "") && (newsObjectArray[indexPath.section].news.text != "")):
            return (tableWidth / currentNews.news.photosAspectRatio)
        default:
            return UITableView.automaticDimension
        }
    }
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension NewsTableController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard
            let maxSection = indexPaths
                .map({ $0.section })
                .max()
        else { return }
        
        if maxSection > newsObjectArray.count - 3,
           !isLoading {
            isLoading = true
            NetworkService.instance.fetchNewsfeed(userID: Session.instance.userId, startFrom: nextFrom) { [weak self] (vkNews, nextFrom)  in
                guard let self = self else { return }
                self.nextFrom = nextFrom
                let indexSet = IndexSet(integersIn: self.newsObjectArray.count ..< self.newsObjectArray.count + vkNews!.count)
                var someArray = [NewsObject]()
                someArray = self.createNewsObjectArray(array: vkNews!)
                self.newsObjectArray.append(contentsOf: someArray)
                self.tableView.insertSections(
                    indexSet,
                    with: .automatic)
                self.isLoading = false
            }
        }
    }
}
