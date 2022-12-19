//
//  NewsListViewController.swift
//  fmh
//
//  Created: 11.05.2022
//

import UIKit

class NewsListViewController: BaseViewController {
    
    var presenter: NewsListPresenterProtocol?
    private var filter = FilterNews()
    private var page = 0
    
    private lazy var newsPullRefresh: UIRefreshControl = {
        let refreshControl = FMHUIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    // ячейка для динамического определения размеров содержимого ячейки
    private let sizingCell = NewsCollectionViewCell()
    
    //MARK: - Создаем CollectionView для множественного выбора обязательно используем allowsMultipleSelection
    private lazy var newsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: "NewsCell")
        collection.register(ActivityIndicatorCell.self, forCellWithReuseIdentifier: "ActivityIndicatorCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.allowsMultipleSelection = true
        collection.alwaysBounceVertical = true
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    private lazy var controlPanel: UIElementsControllPanel = {
        let colorTint = UIColor(red: 0.439, green: 0.439, blue: 0.439, alpha: 1)
        let view = UIElementsControllPanel(title: "Новости", buttons: [
            .info(target: self, action: #selector(buttonInfoAction), color: colorTint, isEnabled: true),
            .sorting(target: self, action: #selector(buttonSortAction),color: colorTint, isEnabled: true),
            .settings(target: self, action: #selector(buttonFilterAction), color: colorTint, isEnabled: true),
            .edit(target: self, action: #selector(buttonDetailsAction), color: colorTint, isHidden: !(presenter?.isAdmin ?? false))
        ])
        return view
    }()
    
    /// pull refresh func
    @objc private func refresh(sender: UIRefreshControl) {
        getNews()
        sender.endRefreshing()
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackGround(name: "BackGround")
        settingsLayouts()
        newsCollectionView.refreshControl = newsPullRefresh
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getNews()
    }
    
 
    // set background
    fileprivate func setBackGround(name: String) {
        if let image = UIImage(named: name) {
            self.view.backgroundColor  = UIColor(patternImage: image)
        }
    }
    
    //MARK: - Set layaouts views
    fileprivate func settingsLayouts() {
        
        /// Safe area margins
        let marginsView = self.view.layoutMarginsGuide
        
        /// Header with button
        self.view.addSubview(controlPanel)
        NSLayoutConstraint.activate([
            controlPanel.topAnchor.constraint(equalTo: marginsView.topAnchor),
            controlPanel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controlPanel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            controlPanel.heightAnchor.constraint(equalToConstant: 55)
        ])
        /// add collectionView
        self.view.addSubview(newsCollectionView)
        NSLayoutConstraint.activate([
            newsCollectionView.topAnchor.constraint(equalTo: controlPanel.bottomAnchor, constant: 0),
            newsCollectionView.bottomAnchor.constraint(equalTo: marginsView.bottomAnchor),
            newsCollectionView.leadingAnchor.constraint(equalTo: marginsView.leadingAnchor),
            newsCollectionView.trailingAnchor.constraint(equalTo: marginsView.trailingAnchor)
        ])
    }
    
    //MARK: - Actions for buttonHeader
    @objc func buttonInfoAction(sender: UIButton) {
        self.showAlert(title: "Информация", message: "На этом экране вы можете увидеть все новости")
    }
    
    @objc func buttonDetailsAction() {
        presenter?.tapOnDetails()
    }
    
    @objc func buttonSortAction() {
        filter.sorted.toggle()
        getNews()

    }
    
    @objc func buttonFilterAction() {
        presenter?.tapOnfilters()
    }
    
}

private extension NewsListViewController {
    
    func getNews() {
        page = 0
        presenter?.news.removeAll()
        presenter?.getAllNews(filter: filter, page: page)
    }
}

//MARK: - Extension for CollectionView

extension NewsListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.news.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if presenter?.pages ?? 0 > page && indexPath.row == (presenter?.news.count ?? 0) - 1 && presenter?.pages != 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityIndicatorCell", for: indexPath) as! ActivityIndicatorCell
            cell.activityIndicator.startAnimating()
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCollectionViewCell
            
            if let item = presenter?.news[indexPath.row] {
                cell.configure(model: item)
            }
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if presenter?.pages ?? 0 > page && indexPath.row == (presenter?.news.count ?? 0) - 1 && presenter?.pages != 1 {
            page += 1
            presenter?.getAllNews(filter: filter, page: page)
        }
    }
}

extension NewsListViewController: UICollectionViewDelegate {
    
    //MARK: - Переопределение анимации сворачивания ячейки
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        collectionView.deselectItem(at: indexPath, animated: true)
        collectionView.performBatchUpdates(nil)
        return true
    }
    //MARK: - Переопределение анимации разворачивания ячейки
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        collectionView.performBatchUpdates(nil)
        return true
    }
}

//MARK: - Расчет динамической ячейки
extension NewsListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let isSelected = collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false

        if let item = presenter?.news[indexPath.row] {
            sizingCell.configure(model: item)
        }
        sizingCell.frame = CGRect(
            origin: .zero,
            size: CGSize(
                width: collectionView.bounds.width,
                height: 500))
        sizingCell.isSelected = isSelected
        sizingCell.setNeedsLayout()
        sizingCell.layoutIfNeeded()
        let size = sizingCell.systemLayoutSizeFitting(CGSize(width: collectionView.bounds.width, height: .greatestFiniteMagnitude), withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return -1
    }
}

//MARK: - NewsPresenterOutput
extension NewsListViewController: NewsListPresenterDelegate {

    func updatedNews() {
        newsCollectionView.reloadData()
    }
}

//MARK: - FilterNewsDelegate
extension NewsListViewController: FilterNewsDelegate {
    func filtering(filter: FilterNews?) {
        guard let filter = filter else { return }
        self.filter = filter
        getNews()
    }
}





