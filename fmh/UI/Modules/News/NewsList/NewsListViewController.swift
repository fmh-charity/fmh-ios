//
//  NewsListViewController.swift
//  fmh
//
//  Created: 14.06.2022
//

import UIKit

class NewsListViewController: UIViewController, NewsListViewControllerProtocol {

    var presenter: NewsListPresenterInput?
    var onCompletion: (() -> ())?

    private lazy var controlPanel: UIView = {
        let view = NewsListControlPanel()
        view.sortButton.addTarget(self, action: #selector(sortAction), for: .touchUpInside)
        view.filterButton.addTarget(self, action: #selector(filterAction), for: .touchUpInside)
        view.editButton.addTarget(self, action: #selector(editAction), for: .touchUpInside)

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout() // <- Перенести в класс
        /// Если ставить автоматически то необходимо переопределять метод preferredLayoutAttributesFitting в UICollectionViewCell
        //flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        flowLayout.minimumLineSpacing = -0.5 //10
        flowLayout.minimumInteritemSpacing = 0

        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.backgroundColor = .clear
        collection.allowsMultipleSelection = true
        collection.showsVerticalScrollIndicator = true
        collection.showsHorizontalScrollIndicator = false
        collection.alwaysBounceVertical = true

        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    private lazy var dataSource: NewsListDataSource = {
        let collectionViewAdapter = NewsListDataSource(collectionView: self.collectionView)
        return collectionViewAdapter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Новости"

        setNavigationBarMenuButton()
        setNavigationBarLogo()
        setNavigationBarRightButtons()
        
        commonInit()
        setLayouts()

        /// Получаем список новостей и обновляем коллекцию и бэкграунд
        presenter?.getNews{ [unowned self] news in
            if let news = news {
                self.dataSource.data = news
            }
            self.upDateBackGroundCollectionView(collectionView: self.collectionView)
        }

    }

    private func commonInit() {
        if let image = UIImage(named: "BackGround") {
            self.view.backgroundColor  = UIColor(patternImage: image)
        }
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
    }

    private func setLayouts() {
        view.addSubview(controlPanel)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            controlPanel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            controlPanel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controlPanel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            controlPanel.heightAnchor.constraint(equalToConstant: 44),

            collectionView.topAnchor.constraint(equalTo: controlPanel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    //MARK: - UpDate BackGround CollectionView
    private func upDateBackGroundCollectionView(collectionView: UICollectionView) {
        /// Проверка на наличие ячеек
        guard collectionView.numberOfItems(inSection: 0) == 0 else {
            collectionView.layer.sublayers?.removeAll{$0.name == "emptyContent"}
            collectionView.backgroundColor = .clear
            return
        }

        let contentSize = collectionView.safeAreaLayoutGuide.layoutFrame
        let frameWidth = contentSize.width * 0.5

        let imageLayer = CALayer()
        imageLayer.contents = UIImage(named: "Butterfly.color")?.cgImage
        imageLayer.frame = .init(x: 0, y: 0, width: frameWidth, height: frameWidth)

        let titleLayer = CATextLayer()
        //titleLayer.font =
        titleLayer.fontSize = 16
        titleLayer.alignmentMode = .center
        titleLayer.isWrapped = true
        titleLayer.foregroundColor = UIColor.gray.cgColor
        titleLayer.string = "Здесь нет ни одной новости."
        titleLayer.frame = .init(x: 0, y: imageLayer.bounds.height + 50.0, width: frameWidth, height: 100.0)

        let frameHeight = imageLayer.bounds.height + titleLayer.bounds.height + 50
        let layerContainer = CALayer()
        layerContainer.name = "emptyContent"
        layerContainer.frame = .init(x: 0, y: 0, width: frameWidth, height: frameHeight)

        layerContainer.addSublayer(imageLayer)
        layerContainer.addSublayer(titleLayer)
        layerContainer.position = CGPoint(x: contentSize.width / 2, y: (contentSize.height / 2) - 50)

        collectionView.layer.backgroundColor = UIColor.white.cgColor
        collectionView.layer.addSublayer(layerContainer)
    }

    //MARK: - Selectors action
    @objc private func sortAction() {
        dataSource.toggleSortData()
    }

    @objc private func filterAction() {
//        //dataSource.filterData(categary: 3)
//        let filterViewcontroller = NewsFilterViewController()
//        filterViewcontroller.onSafe = { }
//        filterViewcontroller.modalPresentationStyle = .pageSheet
//        present(filterViewcontroller, animated: true)
    }

    @objc private func editAction() {
        print("editAction")
    }

}

// MARK: - EnterPresenterOutput
extension NewsListViewController: NewsListPresenterOutput {

}
