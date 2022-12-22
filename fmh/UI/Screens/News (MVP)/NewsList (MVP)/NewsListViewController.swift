//
//  NewsListViewController.swift
//  fmh
//
//  Created: 11.05.2022
//

import UIKit

class NewsListViewController: BaseViewController{

    var presenter: NewsListPresenterProtocol?
    
    private lazy var newsPullRefresh: UIRefreshControl = {
        let refreshControl = RefreshControl()
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
    
    private lazy var controlPanel: ControllPanel = {
        let colorTint = UIColor(red: 0.439, green: 0.439, blue: 0.439, alpha: 1)
        let view = ControllPanel(title: "Новости", buttons: [
            .init(type: .info, target: self, action: #selector(buttonInfoAction), color: colorTint),
            .init(type: .sorting, target: self, action: #selector(buttonSortAction), color: colorTint),
            .init(type: .settings, target: self, action: #selector(buttonFilterAction), color: colorTint),
            .init(type: .edit, target: self, action: #selector(buttonDetailsAction), color: colorTint, isHidden: !(presenter?.isAdmin ?? false))
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
        setBackGround(name: "bacground.main")
        settingsLayouts()
        newsCollectionView.refreshControl = newsPullRefresh
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getNews()
    }
    
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
            controlPanel.heightAnchor.constraint(equalToConstant: 44)
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
    
    //MARK: - Actions for Button Header
    @objc func buttonInfoAction(sender: UIButton) {
        self.showAlert(title: "Информация", message: "На этом экране вы можете увидеть все новости")
    }
    
    @objc func buttonDetailsAction() {
        presenter?.tapOnDetails()
    }
    
    @objc func buttonSortAction() {
        presenter?.filter.sorted.toggle()
        getNews()

    }
    
    @objc func buttonFilterAction() {
        presenter?.tapOnFilters()
    }
    
}

private extension NewsListViewController {
    
    func getNews() {
        presenter?.curentPage = 0
        presenter?.news.removeAll()
        presenter?.getAllNews(page: presenter?.curentPage)
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
        if presenter?.totalPages ?? 0 > presenter?.curentPage ?? 0 && indexPath.row == (presenter?.news.count ?? 0) - 1 && presenter?.totalPages != 1{
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
        if presenter?.totalPages ?? 0 > presenter?.curentPage ?? 0 && indexPath.row == (presenter?.news.count ?? 0) - 1 && presenter?.totalPages != 1 {
            presenter?.curentPage += 1
            presenter?.getAllNews(page: presenter?.curentPage)
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
//extension NewsListViewController: FilterNewsDelegate {
//    func filtering(filter: FilterNews?) {
//        guard let filter = filter else { return }
//        self.filter = filter
//        getNews()
//    }
//}





