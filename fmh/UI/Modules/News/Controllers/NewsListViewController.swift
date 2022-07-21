//
//  NewsViewController.swift
//  fmh
//
//  Created: 11.05.2022
//

import UIKit


class NewsListViewController: UIViewController, NewsListViewControllerProtocol {
    
    var onCompletion: (() -> ())?
    var presenter: NewsListPresenterInput?
    var moduleFactory = ModuleFactory() // для инициализации detailsViewController
    private var categoryId: Int?
    private var datePublic: String?
    private var filters = [FilterNews?]()
    
    // pull refresh
    private lazy var newsPullRefresh: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString.init(string: "Cекунду...")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    //ячейка для динамического определения размеров содержимого ячейки
    private let sizingCell = NewsCollectionViewCell()
    
    //MARK: - Создаем CollectionView для множественного выбора обязательно используем allowsMultipleSelection
    private lazy var newsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: "NewsCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.allowsMultipleSelection = true
        collection.alwaysBounceVertical = true
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    private lazy var viewHeader: UIView = {
        let view = UIView()
        view.backgroundColor = ConstantNews.Collor.headerNews
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var newsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.font = ConstantNews.Font.titleHeader
        label.text = "Новости"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 16.0
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    /// pull refresh func
    @objc private func refresh(sender: UIRefreshControl) {
        presenter?.getAllNews(filters: filters)
        //newsCollectionView.reloadData()
        sender.endRefreshing()
    }
    
    private func makeButton(image: UIImage?, selector: Selector?) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        if let selector = selector {
            button.addTarget(self, action: selector, for: .touchUpInside)
        }
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackGround(name: "BackGround")
        setLayouts()
        presenter?.getAllNews(filters: filters)
        newsCollectionView.refreshControl = newsPullRefresh
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getAllNews(filters: filters)
        //newsCollectionView.reloadData()
    }
    
    // set background
    fileprivate func setBackGround(name: String) {
        let imageViewBackground = UIImageView(image: UIImage(named: name))
        imageViewBackground.contentMode = .scaleToFill
        imageViewBackground.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(imageViewBackground)
        NSLayoutConstraint.activate([
            imageViewBackground.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            imageViewBackground.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageViewBackground.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imageViewBackground.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    //MARK: - Set layaouts views
    fileprivate func setLayouts() {
        
        /// Create buttons
        let buttonEdit = makeButton(image: UIImage(named: "controlPanel.edit"), selector: #selector(buttonDetailsAction))
        let buttonFilter = makeButton(image: UIImage(named: "controlPanel.filter"), selector: #selector(buttonFilterAction))
        let buttonSort = makeButton(image: UIImage(named: "controlPanel.sorting"), selector: #selector(buttonSortAction))
        let buttonInfo = makeButton(image: UIImage(named: "controlPanel.info"), selector: #selector(buttonInfoAction))
        /// Add buttons in stackButtons
        stack.addArrangedSubview(buttonInfo)
        stack.addArrangedSubview(buttonSort)
        stack.addArrangedSubview(buttonFilter)
        stack.addArrangedSubview(buttonEdit)
        
        /// Safe area margins
        let marginsView = self.view.layoutMarginsGuide
        
        /// Header with button
        self.view.addSubview(viewHeader)
        NSLayoutConstraint.activate([
            viewHeader.topAnchor.constraint(equalTo: marginsView.topAnchor),
            viewHeader.leadingAnchor.constraint(equalTo: marginsView.leadingAnchor),
            viewHeader.trailingAnchor.constraint(equalTo: marginsView.trailingAnchor),
            viewHeader.heightAnchor.constraint(equalToConstant: 55)
        ])
        
        /// News Label
        viewHeader.addSubview(newsLabel)
        NSLayoutConstraint.activate([
            newsLabel.topAnchor.constraint(equalTo: viewHeader.topAnchor),
            newsLabel.leadingAnchor.constraint(equalTo: viewHeader.leadingAnchor, constant: 10),
            newsLabel.bottomAnchor.constraint(equalTo: viewHeader.bottomAnchor, constant: 0)
        ])
        /// News stackButtons
        viewHeader.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: viewHeader.topAnchor),
            stack.bottomAnchor.constraint(equalTo: viewHeader.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: newsLabel.trailingAnchor),
            stack.trailingAnchor.constraint(equalTo: viewHeader.trailingAnchor, constant: -8)
        ])
        
        /// add collectionView
        self.view.addSubview(newsCollectionView)
        NSLayoutConstraint.activate([
            newsCollectionView.topAnchor.constraint(equalTo: viewHeader.bottomAnchor, constant: 0),
            newsCollectionView.bottomAnchor.constraint(equalTo: marginsView.bottomAnchor),
            newsCollectionView.leadingAnchor.constraint(equalTo: marginsView.leadingAnchor),
            newsCollectionView.trailingAnchor.constraint(equalTo: marginsView.trailingAnchor)
        ])
        
        
    }
    
    //MARK: - Actions for buttonHeader
    @objc func buttonInfoAction(sender: UIButton) {
        print("button Info")
        // add alert info
    }
    
    @objc func buttonDetailsAction() {
        let detailsNewsVC = moduleFactory.makeDetailsNewsListViewController()
        navigationController?.pushViewController(detailsNewsVC as! UIViewController, animated: true)
    }
    
    @objc func buttonSortAction() {
        presenter?.news.reverse()
        newsCollectionView.reloadData()
    }
    
    @objc func buttonFilterAction() {
        let filteringVC = FilterNewsViewController()
        filteringVC.delegate = self
        navigationController?.pushViewController(filteringVC, animated: true)
    }
    
}

//MARK: - Extension for CollectionView

extension NewsListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("presenter?.news.count: \(presenter?.news.count)")
        return presenter?.news.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCollectionViewCell
        
        if let item = presenter?.news[indexPath.row] {
            cell.configure(model: item)
        }
        return cell
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
        /// Тут надо модельку прокидывать как и в cellForItemAt один в один
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
        //print(size)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    // set -1 for border width 1 pt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return -1
    }
    
}

//MARK: - NewsPresenterOutput
extension NewsListViewController: NewsListPresenterOutput {
    
    func updatedNews() {
        newsCollectionView.reloadData()
    }
    
}

//MARK: - NewsListViewControllerDelegate
extension NewsListViewController: NewsListViewControllerDelegate {
    func filtering(filters: [FilterNews?]) {
        self.filters = filters
        print("category \(categoryId) and date \(datePublic)")
    }
    
    
}





