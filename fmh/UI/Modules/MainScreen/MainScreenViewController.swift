//
//  Main_Screen_ViewController.swift
//  fmh
//
//  Created: 27.04.22
//

import UIKit

final class MainScreenViewController: UIViewController, MainScreenViewControllerProtocol {
    
    var onCompletion: (() -> ())?
    var presenter: MainScreenPresenterInput?
    
    // MARK:: - Internal vars
    
    private let idNewsHeader  = "idNewsHeader"
    private let idNewsFooter = "idNewsFooter"
    private let idWishesHeader  = "idWishesHeader"
    private let idWishesFooter  = "idWishesFooter"
    
    private let cellNewsId = "cellNews"
    private let cellWishesId = "cellWishes"

    let tableview = UITableView()
    
    private var refreshControl = UIRefreshControl()
    
    private var newsItems: [NewsViewModel] = []
    private var wishesItems: [WishesViewModel] = []
    
    private var countNews: Int = 3 {
        didSet {
            configureNewsItems()
            self.tableview.reloadData()
        }
    }
    
    private var countWishes: Int = 6 {
           didSet {
               configureWishesItems()
               self.tableview.reloadData()
           }
       }

    var newsData: [News] = [] {
        didSet {
            
            tableview.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        presenter?.getNewsAll(completion: { news, networkError in
            guard  networkError == nil else {
                return
            }
            if let news = news {
                print("News count all: \(news.count)")
                self.newsData = news
                self.tableview.reloadData() // <- времнно
            }
        })
        
        configureMain()
        
    }
    
    private func configureNewsItems() {
        var mapArray: [NewsViewModel] = []
        var resultArray: [NewsViewModel] = []
        newsData.forEach { if $0.publishEnabled == true {mapArray.append(.init(news: $0))}}
        let sortedArray = mapArray.sorted{ $0.estimatedHours < $1.estimatedHours }
        for index in 0..<sortedArray.count where index < self.countNews {
            resultArray.append(sortedArray[index])
        }
        newsItems = resultArray                       // присваиваем отсортированный массив новостей
    }
    
    private func configureWishesItems() {
        var mapArray: [WishesViewModel] = []
        var resultArray: [WishesViewModel] = []
        wishesData.forEach { if $0.status == "OPEN" || $0.status == "IN_PROGRESS" {mapArray.append(.init(wishes: $0))}}
        let sortedArray = mapArray.sorted{  $0.indexOfColor < $1.indexOfColor  }
        for index in 0..<sortedArray.count where index < self.countWishes {
            resultArray.append(sortedArray[index])
        }
        wishesItems = resultArray                    // присваиваем отсортированный массив просьб
    }
    
    private func configureMain() {
        self.view.addSubview(UIImageView(image: UIImage(named: "MainBackground")))
        self.tableview.backgroundColor = UIColor(white: 0.0, alpha: 0.0)

        configureNewsItems()
        configureWishesItems()
        
        self.tableview.register(NewsCell.self, forCellReuseIdentifier: cellNewsId)
        self.tableview.register(WishesCell.self, forCellReuseIdentifier: cellWishesId)
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        self.tableview.separatorStyle = .none
        setConstraints()
        
        self.tableview.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(swipeGesture), for: .valueChanged)
//
        self.tableview.rowHeight = UITableView.automaticDimension
        
        self.title = "NAV_BAR"  //Временнный тайтл
    }
    
    @objc private func swipeGesture() {                              // обновление даннных страницы
        self.countNews = 3
        self.countWishes = 6
        self.tableview.reloadData()
        self.refreshControl.endRefreshing()
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSourcee
extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return newsItems.count
        case 1: return wishesItems.count
        default: break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellNewsId, for: indexPath) as! NewsCell
            cell.setViewModel(self.newsItems[indexPath.row])
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellWishesId, for: indexPath) as! WishesCell
            cell.setViewModel(self.wishesItems[indexPath.row])
            return cell
        default: break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableView.automaticDimension
        case 1:
            return 180
        default: break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        newsItems[indexPath.row].isExpanded.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerType = HeaderView.HeaderType(rawValue: section) else { return nil }
        let header = HeaderView(type: headerType)
        header.pressUpButton = { (type, tag) in
            switch type {
            case .news:
                switch tag {
                case 0:
                    print("information news")
                case 1:
                    self.countNews = 3
                default:
                    break
                }
            case .wishes:
                switch tag {
                case 0:
                    print("information wishes")
                case 1:
                    print("add")
                case 2:
                    self.countWishes = 6
                default:
                    break
                }
            }
        }
        return header
    }
  
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerType = FooterView.FooterType(rawValue: section) else { return nil }
        let footer = FooterView(type: footerType)
        footer.pressDownButton = { [unowned self] type in
            switch type {
            case .news:
                let difference = self.newsData.count - self.countNews
                switch difference {
                case 0...3:
                    self.countNews += difference
                default:
                    self.countNews = difference
                }
            case .requests:
                let difference = wishesData.count - self.countWishes
                switch difference {
                case 0...6:
                    self.countWishes += difference
                default:
                    self.countWishes = difference
                }
            }
        }
        return footer
    }
    
}

extension MainScreenViewController {
    
    func setConstraints() {
        self.view.addSubview(self.tableview)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableview.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            self.tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            self.tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            self.tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
}

//MARK: -
extension MainScreenViewController: MainScreenPresenterOutput {

}
    
