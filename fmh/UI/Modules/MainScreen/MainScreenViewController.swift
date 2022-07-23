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

    private let tableview = UITableView(frame: .zero, style: .grouped)
    
    private var refreshControl = UIRefreshControl()
    
    var newsItems: [NewsViewModel] = [] {
        didSet {
            self.tableview.reloadSections(IndexSet(integer: 0), with: .automatic)
            self.isProcessing = false
        }
    }
    
    var wishesItems: [WishesViewModel] = [] {
        didSet {
            self.tableview.reloadSections(IndexSet(integer: 1), with: .automatic)
            self.isProcessing = false
        }
    }
    
    var newsData: [News] = []
    var wishesData: [Wishes] = []
    
    var countNews: Int = 3 {
        didSet {
            self.presenter?.getAllNews()
            self.isProcessing = false
        }
    }
    
    var countWishes: Int = 6 {
        didSet {
            self.presenter?.getAllWishes()
            self.isProcessing = false
        }
    }
    
    private var activityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .accentColor
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private var timerErrorLoad: Timer?
    
    private var isProcessing: Bool = false {
        didSet {
            if isProcessing {
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
                self.timerErrorLoad = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(errorLoadData), userInfo: nil, repeats: false)                                          // алерт при ошибке загрузки
            } else {
                self.timerErrorLoad?.invalidate()
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.presenter?.getAllNews()
        self.presenter?.getAllWishes()
        self.isProcessing = true
        self.configureMain()
    }
    
    @objc private func errorLoadData() {
        let alert = UIAlertController(title: "Error", message: "Can't load data, try again..", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func configureMain() {
        self.view.addSubview(UIImageView(image: UIImage(named: "MainBackground")))
        self.tableview.backgroundColor = UIColor(white: 0.0, alpha: 0.0)

        self.tableview.register(NewsCell.self, forCellReuseIdentifier: cellNewsId)
        self.tableview.register(WishesCell.self, forCellReuseIdentifier: cellWishesId)
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        self.tableview.separatorStyle = .none
        
        self.tableview.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(swipeGesture), for: .valueChanged)

        self.tableview.rowHeight = UITableView.automaticDimension
        setConstraints()
        self.title = "NAV_BAR"  //Временнный тайтл
    }
    
    @objc func swipeGesture() {                              // обновление даннных страницы
        self.countNews = 3
        self.countWishes = 6
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
        if indexPath.section == 0 {
        newsItems[indexPath.row].isExpanded.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        60
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
                    self.countNews += 3
                }
            case .requests:
                let difference = self.wishesData.count - self.countWishes
                switch difference {
                case 0...6:
                    self.countWishes += difference
                default:
                    self.countWishes += 6
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
        
        self.tableview.addSubview(self.activityIndicator)
        NSLayoutConstraint.activate([
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.activityIndicator.heightAnchor.constraint(equalToConstant: 50),
            self.activityIndicator.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}

//MARK: -
extension MainScreenViewController: MainScreenPresenterOutput {
    func updatedNews() {
        self.tableview.reloadData()
    }
    
    func createdNews() {
        return
    }
    
}
    
