//
//  DetailsNewsViewController.swift
//  fmh
//
//  Created: 14.05.2022
//

import UIKit

class DetailsNewsViewController: UIViewController, DetailsNewsViewControllerProtocol {
    
    var onCompletion: (() -> ())?
    var presenter: DetailsNewsPresenterInput?
    private var moduleFactory = ModuleFactory() // для инициализации editVC
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
    private let sizingCell = DetailsNewsCollectionViewCell()
    
    //MARK: - Создаем CollectionView для множественного выбора обязательно используем allowsMultipleSelection
    private lazy var detailsNewsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.register(DetailsNewsCollectionViewCell.self, forCellWithReuseIdentifier: "DetailsNewsCell")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = true
        view.allowsMultipleSelection = true
        //view.allowsSelection = true
        view.alwaysBounceVertical = true
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private lazy var viewHeader: UIView  = {
        let view = UIView()
        view.backgroundColor = ConstantNews.Collor.headerSettingNews
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var newsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = ConstantNews.Font.titleHeader
        label.text = "Панель управления новостями"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private func makeButton(image: UIImage?, selector: Selector?) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        if let selector = selector {
            button.addTarget(self, action: selector, for: .touchUpInside)
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        presenter?.getAllNews(filters: filters)
        sender.endRefreshing()
    }
//MARK: - VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackGround(name: "BackGround")
        setLayouts()
        presenter?.getAllNews(filters: filters)
        detailsNewsCollectionView.refreshControl = newsPullRefresh
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getAllNews(filters: filters)
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
        let buttonFilter = makeButton(image: UIImage(named: "controlPanel.filter"), selector: #selector(buttonFilterNewsAction))
        let buttonSort = makeButton(image: UIImage(named: "controlPanel.sorting"), selector: #selector(buttonSotredNewsAction))
        let buttonAdd = makeButton(image: UIImage(named: "controlPanel.add"), selector: #selector(buttonAddNewsAction))
        /// Add buttons in stackButtons
        
        stack.addArrangedSubview(buttonSort)
        stack.addArrangedSubview(buttonFilter)
        stack.addArrangedSubview(buttonAdd)
        
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
            newsLabel.bottomAnchor.constraint(equalTo: viewHeader.bottomAnchor, constant: 0),
            newsLabel.widthAnchor.constraint(equalToConstant: 200)
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
        self.view.addSubview(detailsNewsCollectionView)
        NSLayoutConstraint.activate([
            detailsNewsCollectionView.topAnchor.constraint(equalTo: viewHeader.bottomAnchor, constant: 0),
            detailsNewsCollectionView.bottomAnchor.constraint(equalTo: marginsView.bottomAnchor),
            detailsNewsCollectionView.leadingAnchor.constraint(equalTo: marginsView.leadingAnchor),
            detailsNewsCollectionView.trailingAnchor.constraint(equalTo: marginsView.trailingAnchor)
        ])
        
        
    }
    
    //MARK: -  Action button
    @objc func buttonAddNewsAction() {
        let addController = moduleFactory.makeEditNewsViewController()
        navigationController?.pushViewController(addController, animated: true)
    }
    
    @objc func buttonFilterNewsAction() {
        let addController = FilterNewsViewController()
        addController.delegate = self
        navigationController?.pushViewController(addController, animated: true)
    }
    
    @objc func buttonSotredNewsAction() {
        presenter?.news.reverse()
        detailsNewsCollectionView.reloadData()
    }
    
}

//MARK: - Extension for CollectionView

extension DetailsNewsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("presenter?.news.count: \(presenter?.news.count)")
        return presenter?.news.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsNewsCell", for: indexPath) as! DetailsNewsCollectionViewCell
        cell.delegate = self
        cell.index = indexPath.row
        if let item = presenter?.news[indexPath.row] {
            cell.configure(model: item)
        }
        return cell
    }
}

//MARK: - Расчет динамической ячейки
extension DetailsNewsViewController: UICollectionViewDelegateFlowLayout {
    
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
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
}

extension DetailsNewsViewController: UICollectionViewDelegate {
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

//MARK: - action for ButtonCell
extension DetailsNewsViewController: DetailsNewsCollectionViewCellDelegate {
    func editDetailsNewsCollectionViewCellDelegate(_ detailsCell: UICollectionViewCell, didClickEditButton index: Int) {
        let editNewsVC = moduleFactory.makeEditNewsViewController()
        editNewsVC.destinationName = "editNews"
        let id = presenter?.news[index].id
        editNewsVC.idNews = id
        navigationController?.pushViewController(editNewsVC, animated: true)
    }
    
    func deleteDetailsNewsCollectionViewCellDelegate(_ detailsCell: UICollectionViewCell, didClickDeleteButton index: Int) {
        
        guard let id = presenter?.news[index].id else { return }
        print("механизм удаление ячейки и данных из бека по индексу \(id)")
        presenter?.deleteNews(id: id, index: index)
    }
}

//MARK: - DetailsNewsPresenterOutput

extension DetailsNewsViewController: DetailsNewsPresenterOutput {
    
    func updatedNews() {
        detailsNewsCollectionView.reloadData()
        
    }
}
//MARK: - DetailsNewsViewControllerDelegate

extension DetailsNewsViewController: DetailsNewsViewControllerDelegate {
    func filtering(filters: [FilterNews?]) {
        self.filters = filters
        print("filters = \(self.filters)")
    }
    
    
}





